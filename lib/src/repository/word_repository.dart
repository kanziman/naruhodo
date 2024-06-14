import 'dart:developer';
import 'dart:math' as m;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/util/custom/common_consts.dart';

class WordRepository {
  final FirebaseFirestore firestore;
  late CollectionReference alphabetCollection;
  late CollectionReference sentenceCollection;
  late CollectionReference patternsCollection;
  late CollectionReference wordCollection;

  WordRepository({required this.firestore}) {
    alphabetCollection = firestore.collection('alphabet');
    sentenceCollection = firestore.collection('sentences');
    patternsCollection = firestore.collection('patterns');
    wordCollection = firestore.collection('word');
  }

  final _random = m.Random();

  Query getQuery(QueryRequest queryRequest, {String? target}) {
    log('QueryRequest: $queryRequest');
    log('targetL $target');
    Query? query;
    if (queryRequest.topic?.toLowerCase() == 'hiragana' ||
        queryRequest.topic?.toLowerCase() == 'katakana') {
      query = alphabetCollection.where('topic',
          isEqualTo: queryRequest.topic?.toLowerCase());
    } else if (queryRequest.topic?.toLowerCase() == 'word') {
      String subjectName =
          queryRequest.camelCaseToUnderscore(queryRequest.subjectType.name);
      query = wordCollection.where('topic', isEqualTo: subjectName);
    } else if (queryRequest.subjectType.name.toLowerCase() == 'pattern') {
      query = patternsCollection
          .doc(queryRequest.subjectType.name)
          .collection(queryRequest.from!.padLeft(3, '0'));
    } else if (queryRequest.topic?.toLowerCase() == 'quiz' && target != null) {
      query = patternsCollection
          .doc('pattern')
          .collection(target)
          .where('topic', isEqualTo: target);
    }

    if (query == null) {
      throw ArgumentError('Invalid topic: ${queryRequest.topic}');
    }

    return query;
  }

  Future<List<Word>> readForAlphabet(QueryRequest queryRequest) async {
    List<Word> wordList = await fetchData(
      query: getQuery(queryRequest),
      useCache: queryRequest.useCache ?? false,
    );

    wordList.sort((a, b) => a.seq!.compareTo(b.seq!));
    _insertDummyWhenLetter(wordList);
    return wordList;
  }

  Future<List<Word>> readForAlphabetRandom(QueryRequest queryRequest) async {
    List<Word> wordList = await fetchData(
      query: getQuery(queryRequest),
      useCache: queryRequest.useCache ?? false,
    );
    return randomElements(wordList, CARDNUM);
  }

  Future<List<Word>> readForWordRandom(QueryRequest queryRequest) async {
    List<Word> wordList = await fetchData(
      query: getQuery(queryRequest),
      useCache: queryRequest.useCache ?? false,
    );
    return randomElements(wordList, CARDNUM);
  }

  Future<List<Word>> readForPattern(QueryRequest queryRequest) async {
    return await fetchData(
      query: getQuery(queryRequest),
      useCache: queryRequest.useCache ?? false,
    );
  }

  /// QUIZ - patterns / sentences
  Future<List<Word>> readForQuizRandom(QueryRequest queryRequest) async {
    /// QueryRequest(subject: quiz, topic: topic, from: 008,009)
    List<Word> wordList = [];
    List<String> targets = queryRequest.from!.split(',');
    for (var target in targets) {
      Query query = getQuery(queryRequest, target: target);
      wordList.addAll(await fetchData(
          query: query, useCache: queryRequest.useCache ?? false));
    }

    return randomElements(wordList, CARDNUM);
  }

  Future<List<Word>> fetchData({
    required Query query,
    required bool useCache,
  }) async {
    QuerySnapshot snapshot;
    List<Word> docs;
    try {
      if (useCache) {
        snapshot =
            await query.get(const GetOptions(source: Source.cache)).catchError(
          (error) async {
            // 캐시 실패 시 네트워크에서 다시 시도
            return await query.get(const GetOptions(source: Source.server));
          },
        );
        if (snapshot.docs.isEmpty) {
          log('docs empty. retry without cache.');
          snapshot = await query.get(const GetOptions(source: Source.server));
        }
      } else {
        snapshot = await query.get(const GetOptions(source: Source.server));
      }

      bool isFromCache = snapshot.metadata.isFromCache;
      log("Data fetched from ${isFromCache ? 'cache' : 'network'}.");

      docs = snapshot.docs
          .map((doc) => Word.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
      log("Data fetched from ${docs.length}.");
    } catch (e, s) {
      log('Failed to get', error: e, stackTrace: s);
      return [];
    }
    return docs;
  }

  List<T> randomElements<T>(List<T> list, int count) {
    List<T> copyList = List.from(list);
    copyList.shuffle(_random);
    return copyList.take(count).toList();
  }

  void _insertDummyWhenLetter(List<Word> wordList) {
    Map<String, dynamic> dummyDataTemplate = {
      "character": "",
    };

    void insertMultipleDummyDataAfterSeq(int seq, int count) {
      for (int i = 0; i < count; i++) {
        int index = wordList.indexWhere((word) => word.seq == seq) + 1 + i;
        if (index != -1) {
          wordList.insert(
              index,
              Word.fromJson({
                ...dummyDataTemplate,
              }));
        }
      }
    }

    insertMultipleDummyDataAfterSeq(36, 1);
    insertMultipleDummyDataAfterSeq(37, 1);
    insertMultipleDummyDataAfterSeq(44, 1);
    insertMultipleDummyDataAfterSeq(45, 1);
  }
}
