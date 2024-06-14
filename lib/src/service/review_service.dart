import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/anki_type.dart';
import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/progress.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/model/voca.dart';
import 'package:naruhodo/src/repository/voca_repository.dart';
import 'package:naruhodo/theme/component/toast/toast.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReviewService extends ChangeNotifier {
  final VocaRepository vocaRepository;
  ReviewService({required this.vocaRepository});

  Map<String, Progress> progressMap = {};
  Map<String, Map<String, dynamic>> oldProgressMap = {};
  Map<String, dynamic> vocasMap = {};
  List<Voca> vocaList = [];
  Map<String, List<Voca>> reviewedListMap = {};
  static const List<String> levels = ['N5', 'N4', 'N3', 'N2', 'N1'];

  Future<void> saveLastReviewedIndex(String level, int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastReviewedIndex_$level', index);
  }

  Future<int> loadLastReviewedIndex(String level) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('lastReviewedIndex_$level') ?? 0;
  }

  void addOrUpdateAnkiCard(
      Voca voca, AnkiType anki, User user, Function goNextPage) {
    vocaRepository.addOrUpdateAnkiCard(voca, anki, user).then((success) {
      if (success) {
        log("Update successful or card deleted.");
        if (AnkiType.pass != anki) Toast.show(S.current.added);
      } else {
        log("Failed to update or delete card.");
      }
      goNextPage();
    }).catchError((error) {
      log("An unexpected error occurred: $error");
    });
  }

  void addReview(Voca voca) {
    String level = voca.topic.toUpperCase();
    if (!reviewedListMap.containsKey(level)) {
      reviewedListMap[level] = [];
    }

    if (!reviewedListMap[level]!
        .any((existingVoca) => existingVoca.id == voca.id)) {
      reviewedListMap[level]!.add(voca);
      _updateProgress(level);
    }

    notifyListeners();
  }

  Future<List<Voca>> loadVocaListFromDB(uid, {useCache}) async {
    QueryRequest queryRequest = QueryRequest(
      subjectType: SubjectType.voca,
      useCache: useCache ?? false,
      from: uid,
    );
    return vocaRepository.readForReview(queryRequest);
  }

  Future<void> loadData(String uid, {useCache = false}) async {
    log('loadData: $uid');

    vocaList = await loadVocaListFromDB(uid, useCache: useCache);
    // log('vocaList: $vocaList');

    _populateVocasMap(); // by LEVEL
    // log('vocasMap $vocasMap');
    _populateReviewedListMap();

    _calculateProgress();

    notifyListeners();
  }

  void _populateVocasMap() {
    vocasMap.clear();
    for (var level in levels) {
      List<Voca> filteredList =
          vocaList.where((voca) => voca.topic.toUpperCase() == level).toList();
      vocasMap[level] = filteredList;
      // log('Just added $level with ${filteredList.length} items');
    }
  }

  void _populateReviewedListMap() {
    reviewedListMap.clear();
    DateTime now = DateTime.now();
    for (var voca in vocaList) {
      if (voca.lastReview != null && voca.lastReview!.isBefore(now)) {
        String topicKey = voca.topic.toUpperCase();
        reviewedListMap.putIfAbsent(topicKey, () => []).add(voca);
      }
    }
  }

  void _calculateProgress() {
    progressMap.clear();
    vocasMap.forEach((level, vocaList) {
      List<Voca> reviewedList = reviewedListMap[level] ?? [];

      if (vocaList.isNotEmpty) {
        Progress progress = Progress.fromVocas(level, vocaList, reviewedList);
        progressMap[level] = progress;
      }
    });
    log('progressMap ${progressMap.toString()}');
  }

  void _updateProgress(String level) {
    List<Voca> vocaList = vocasMap[level] ?? [];
    List<Voca> reviewedList = reviewedListMap[level] ?? [];
    Progress progress = Progress.fromVocas(level, vocaList, reviewedList);
    progressMap[level] = progress;
  }

  Future<void> resetUserReview(String topic, User? user) async {
    await vocaRepository.resetUserReview(topic, user);
    loadData(user!.uid);
  }
}
