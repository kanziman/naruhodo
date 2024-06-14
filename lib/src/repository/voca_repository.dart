import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:naruhodo/src/enum/anki_type.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/model/voca.dart';

class VocaRepository {
  final FirebaseFirestore firestore;
  late CollectionReference n5Collection;
  late CollectionReference n4Collection;
  late CollectionReference n3Collection;
  late CollectionReference n2Collection;
  late CollectionReference n1Collection;

  VocaRepository({required this.firestore}) {
    n5Collection = firestore.collection('N5');
    n4Collection = firestore.collection('N4');
    n3Collection = firestore.collection('N3');
    n2Collection = firestore.collection('N2');
    n1Collection = firestore.collection('N1');
  }

  /// VocaPage에서 특정 주제(category) click
  Future<List<Voca>> readForVoca(QueryRequest queryRequest) async {
    log("readForVoca!!! $queryRequest");

    Query query;

    if (queryRequest.topic!.toUpperCase() == 'N5') {
      query = n5Collection.where('category', isEqualTo: queryRequest.from);
    } else if (queryRequest.topic!.toUpperCase() == 'N4') {
      query = n4Collection.where('category', isEqualTo: queryRequest.from);
    } else if (queryRequest.topic!.toUpperCase() == 'N3') {
      query = n3Collection.where('category', isEqualTo: queryRequest.from);
    } else if (queryRequest.topic!.toUpperCase() == 'N2') {
      query = n2Collection.where('category', isEqualTo: queryRequest.from);
    } else {
      query = n1Collection.where('category', isEqualTo: queryRequest.from);
    }

    List<Voca> data =
        await fetchData(query: query, useCache: queryRequest.useCache ?? false);
    // print(data);
    return data;
  }

  /// mypage에서 유저의 리뷰 카드리스트
  Future<List<Voca>> readForReview(QueryRequest queryRequest) async {
    log("readForReview!!! $queryRequest");
    Query query = FirebaseFirestore.instance
        .collection('users')
        .doc(queryRequest.from) // uid
        .collection('anki')
        .where('nextReview',
            isLessThanOrEqualTo: DateTime.now().toIso8601String());

    List<Voca> data =
        await fetchData(query: query, useCache: queryRequest.useCache ?? false);
    return data;
  }

  Future<bool> addOrUpdateAnkiCard(Voca voca, AnkiType anki, User user) async {
    var docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('anki')
        .doc(voca.id);

    try {
      DateTime? nextReviewDate;
      DateTime? lastReviewDate;
      bool isReview = (voca.nextReview != null);
      lastReviewDate = isReview ? DateTime.now() : null;

      switch (anki) {
        case AnkiType.keep:
          nextReviewDate = DateTime.now();
          break;
        case AnkiType.hard:
          nextReviewDate =
              DateTime.now().add(const Duration(days: 1)); // Today + 1 day
          break;
        case AnkiType.good:
          nextReviewDate =
              DateTime.now().add(const Duration(days: 3)); // Today + 3 days
          break;
        case AnkiType.pass:
          await docRef.delete();
          return true;
      }

      Voca updatedVoca = Voca(
        id: voca.id,
        topic: voca.topic,
        category: voca.category,
        voca: voca.voca,
        expression: voca.expression,
        vocaMean: voca.vocaMean,
        type: voca.type,
        meaning: voca.meaning,
        quiz: voca.quiz,
        seq: voca.seq,
        nextReview: nextReviewDate,
        lastReview: lastReviewDate,
        voice: voca.voice,
      );

      await docRef.set(updatedVoca.toJson());
      return true; // Successfully updated the document
    } catch (e) {
      log("Error updating card: $e");
      return false; // Indicate failure
    }
  }

  Future<List<Voca>> fetchData({
    required Query query,
    required bool useCache,
  }) async {
    QuerySnapshot snapshot;
    List<Voca> vocaList;
    try {
      if (useCache) {
        snapshot = await query
            .get(const GetOptions(source: Source.cache))
            .catchError((error) async {
          // 캐시 실패 시 네트워크에서 다시 시도
          return await query.get(const GetOptions(source: Source.server));
        });
        if (snapshot.docs.isEmpty) {
          log('docs empty. retry without cache.');
          snapshot = await query.get(const GetOptions(source: Source.server));
        }
      } else {
        snapshot = await query.get(const GetOptions(source: Source.server));
      }

      bool isFromCache = snapshot.metadata.isFromCache;
      log("Data fetched from ${isFromCache ? 'cache' : 'network'}.");

      vocaList = snapshot.docs
          .map((doc) =>
              Voca.fromJson(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      vocaList.sort((a, b) => a.seq!.compareTo(b.seq!));

      log("Data fetched ${vocaList.length}");
    } catch (e, s) {
      log('Failed to fetch', error: e, stackTrace: s);
      return [];
    }
    return vocaList;
  }

  Future<void> resetUserReview(topic, User? user) async {
    // Firestore 인스턴스
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

// 사용자 ID
    final String userId = user!.uid;

// 특정 토픽에 대한 쿼리
    final Query query = firestore
        .collection('users')
        .doc(userId)
        .collection('anki')
        .where('topic', isEqualTo: topic);

    // 쿼리 결과에 대해 각 문서 삭제
    final querySnapshot = await query.get();
    for (var doc in querySnapshot.docs) {
      await doc.reference.delete().then((_) {
        log("Document successfully deleted!");
      }).catchError((error) {
        log("Error removing document: $error");
      });
    }
  }
}
