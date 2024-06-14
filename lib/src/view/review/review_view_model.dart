import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/enum/anki_type.dart';
import 'package:naruhodo/src/model/voca.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/src/service/review_service.dart';
import 'package:naruhodo/src/service/tts_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/view/base/base_view_model.dart';

class ReviewViewModel extends BaseViewModel {
  late final LearningService learningService;
  late final AuthService authService;
  late final TtsService ttsService;
  late final ReviewService reviewService;

  List<Voca> vocaList = [];
  int _currentPage = 0;
  late final int level;
  late final int? point;
  PageController? _pageController;
  late final Future<void> initializer;

  ReviewViewModel({
    required this.vocaList,
    required this.learningService,
    required this.ttsService,
    required this.authService,
    required this.level,
    required this.reviewService,
    this.point,
  }) {
    initializer = _initialize();
  }
  final AudioPlayer _audioPlayer = AudioPlayer();
  void playAudio(url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  Future<void> _initialize() async {
    int startIndex = point ??
        await reviewService.loadLastReviewedIndex(levelToString(level));

    _currentPage = startIndex;
    _pageController = PageController(initialPage: startIndex);
    _pageController!.addListener(() {
      _currentPage = _pageController!.page!.round();
      _updatePage();
    });
  }

  /// PAGE
  String get currentLevel => levelToString(level);
  int get currentPage => _currentPage;
  PageController get pageController => _pageController!;
  double get percent =>
      (min(_currentPage, vocaList.length) / vocaList.length).clamp(0, 1);
  String get totalIndex =>
      '${min(_currentPage, vocaList.length)}/${vocaList.length}';
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == vocaList.length - 1;

  void _updatePage() {
    saveLastReviewedIndex(levelToString(level), _currentPage);
    _resetVisibilityState();
    notifyListeners();
  }

  void goNextPage() {
    if (!isLastPage) {
      _pageController!.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void saveLastReviewedIndex(String level, int index) async {
    reviewService.saveLastReviewedIndex(level, index);
  }

  String levelToString(int level) {
    switch (level) {
      case 0:
        return 'n5';
      case 1:
        return 'n4';
      case 2:
        return 'n3';
      default:
        throw ArgumentError('Invalid level: $level');
    }
  }

  /// VOCA
  bool get isSwitchOn => learningService.isSwitchOn;
  bool get isShowConfetti => learningService.isShowConfetti;
  bool get isVisible => learningService.isVisible;
  bool get isPartiallyVisible => learningService.isPartiallyVisible;
  void toggleSwtich() {
    learningService.toggleSwtich();
    notifyListeners();
  }

  void toggleVisibility() {
    learningService.toggleVisibility();
    if (isLastPage && learningService.isVisible) {
      updateAtLastPage();
    }
    notifyListeners();
  }

  void _resetVisibilityState() {
    learningService.resetVisibilityState();
  }

  void updateAtLastPage() {
    if (isLastPage) {
      _currentPage++;
      learningService.showConfetti();
    }
  }

  void saveCurrentCard(BuildContext context, AnkiType anki) {
    User? user = authService.currentUser();
    if (user == null) {
      Navigator.pushNamed(
        context,
        RoutePath.auth,
      );
      return;
    }
    Voca currentCard = vocaList[currentPage];

    // repo update
    reviewService.addOrUpdateAnkiCard(currentCard, anki, user, goNextPage);
    // reviewcards update
    reviewService.addReview(currentCard);
  }

  /// DATA
  Future<void> refreshData() async {
    loadData(useCache: false);
  }

  Future<void> loadData({useCache}) async {
    isBusy = true;
    ttsService.changeTtsNormal();
    final results = await Future.wait([
      learningService.load(useCache: useCache),
      Future.delayed(const Duration(milliseconds: 555)),
    ]);
    vocaList = results[0];
    isBusy = false;
  }

  @override
  void dispose() {
    _pageController!.removeListener(_updatePage);
    _pageController!.dispose();
    _resetVisibilityState();
    super.dispose();
  }
}
