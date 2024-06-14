import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/speak_service.dart';
import 'package:naruhodo/src/service/tts_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/view/base/base_view_model.dart';

class QuizViewModel extends BaseViewModel {
  int _currentPage = 0;
  List<Word> wordList = [];
  void Function()? hideSnackbarCallback;

  late final LearningService learningService;
  late final SpeakService speakService;
  late final TtsService ttsService;

  final PageController _pageController = PageController();

  QuizViewModel({
    required this.learningService,
    required this.speakService,
    required this.ttsService,
  }) {
    _pageController.addListener(_updatePage);
    speakService.addListener(notifyListeners);
  }
  final AudioPlayer _audioPlayer = AudioPlayer();
  void playAudio(url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  void init(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      speakService.isPreparing = false;
      speakService.updateWordsSpoken("");
    });
  }

  void hideSnackbar() {
    hideSnackbarCallback?.call();
  }

  get toggleListen => speakService.toggleListen;
  get isPreparing => speakService.isPreparing;
  get level => speakService.level;
  get isListening => speakService.isListening;
  get speechEnabled => speakService.speechEnabled;
  int get currentPage => _currentPage;
  PageController get pageController => _pageController;
  double get percent =>
      (min(_currentPage, wordList.length) / wordList.length).clamp(0, 1);
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == wordList.length - 1;
  bool get isVisible => learningService.isVisible;
  bool get isPartiallyVisible => learningService.isPartiallyVisible;
  bool get isShowConfetti => learningService.isShowConfetti;
  String get totalIndex =>
      '${min(_currentPage, wordList.length)}/${wordList.length}';

  void toggleVisibility() {
    learningService.toggleVisibility();
    if (isLastPage && learningService.isVisible) {
      updateAtLastPage();
    }
    notifyListeners();
  }

  void _resetVisibilityState() {
    hideSnackbar();
    learningService.resetVisibilityState();
  }

  void _updatePage() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (_currentPage != currentPage) {
      _currentPage = currentPage;
      speakService.updateWordsSpoken("");
    }
    _resetVisibilityState();
  }

  void updateAtLastPage() {
    if (isLastPage) {
      _currentPage++;
      learningService.showConfetti();
      notifyListeners();
    }
  }

  void changeTtsNormal() {
    ttsService.changeTtsNormal();
  }

  /// DATA
  Future<void> refreshData() async {
    loadData(isCache: false);
  }

  Future<void> loadData({isCache = true}) async {
    isBusy = true;
    changeTtsNormal();
    final results = await Future.wait([
      learningService.load(),
      Future.delayed(const Duration(milliseconds: 555)),
    ]);
    wordList = results[0];
    isBusy = false;
  }

  @override
  void dispose() {
    _pageController.removeListener(_updatePage);
    _pageController.dispose();
    speakService.removeListener(notifyListeners);
    hideSnackbarCallback = null;
    _resetVisibilityState();
    super.dispose();
  }
}
