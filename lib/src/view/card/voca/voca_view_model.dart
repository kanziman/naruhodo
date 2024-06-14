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

class VocaViewModel extends BaseViewModel {
  int _currentPage = 0;
  List<Voca> vocaList = [];
  late final LearningService learningService;
  late final ReviewService reviewService;
  late final AuthService authService;
  late final TtsService ttsService;
  final PageController _pageController = PageController();

  VocaViewModel({
    required this.learningService,
    required this.ttsService,
    required this.authService,
    required this.reviewService,
  }) {
    _pageController.addListener(_updatePage);
  }
  final AudioPlayer _audioPlayer = AudioPlayer();
  void playAudio(url) async {
    await _audioPlayer.play(UrlSource(url));
    await _audioPlayer.setPlaybackRate(1);
  }

  /// PAGE
  // int get currentPage => min(_currentPage, vocaList.length - 1);
  PageController get pageController => _pageController;
  double get percent =>
      (min(_currentPage, vocaList.length) / vocaList.length).clamp(0, 1);
  String get totalIndex =>
      '${min(_currentPage, vocaList.length)}/${vocaList.length}';
  bool get isShowConfetti => learningService.isShowConfetti;
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == vocaList.length - 1;

  void goNextPage() {
    _pageController.nextPage(
      duration: const Duration(microseconds: 888),
      curve: Curves.easeInOut,
    );
  }

  void _updatePage() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (_currentPage != currentPage) {
      _currentPage = currentPage;
      notifyListeners();
    }
    _resetVisibilityState();
  }

  void updateAtLastPage() {
    if (isLastPage) {
      _currentPage++;
      learningService.showConfetti();
    }
  }

  /// VOCA
  bool get isSwitchOn => learningService.isSwitchOn;
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

  void saveCurrentCard(BuildContext context, AnkiType anki) {
    User? user = authService.currentUser();
    if (user == null) {
      Navigator.pushNamed(
        context,
        RoutePath.auth,
      );
      return;
    }
    Voca currentCard = vocaList[min(_currentPage, vocaList.length - 1)];
    reviewService.addOrUpdateAnkiCard(currentCard, anki, user, goNextPage);
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
    _pageController.removeListener(_updatePage);
    _pageController.dispose();
    _resetVisibilityState();
    super.dispose();
  }
}
