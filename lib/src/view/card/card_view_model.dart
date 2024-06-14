import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/tts_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/view/base/base_view_model.dart';

class CardViewModel extends BaseViewModel {
  int _currentPage = 0;
  List<Word> wordList = [];
  List<String> urlList = [];
  late final LearningService learningService;
  late final TtsService ttsService;
  final PageController _pageController = PageController();
  final FlipCardController _flipController = FlipCardController();

  CardViewModel({
    required this.learningService,
    required this.ttsService,
  }) {
    _pageController.addListener(_updatePage);
  }

  int get currentPage => _currentPage;

  PageController get pageController => _pageController;
  FlipCardController get flipController => _flipController;
  double get percent =>
      (min(_currentPage, wordList.length) / wordList.length).clamp(0, 1);
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == wordList.length - 1;
  String get totalIndex =>
      '${min(_currentPage, wordList.length)}/${wordList.length}';

  bool get isShowConfetti => learningService.isShowConfetti;

  Future<void> refreshData() async {
    loadData(useCache: false);
  }

  Future<void> loadData({useCache}) async {
    isBusy = true;
    ttsService.changeTtsSlow();
    final results = await Future.wait([
      learningService.load(useCache: useCache),
      Future.delayed(const Duration(milliseconds: 555)),
    ]);
    wordList = results[0];
    isBusy = false;
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  void playAudio(url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  void _updatePage() {
    final currentPage = _pageController.page?.round() ?? 0;
    if (_currentPage != currentPage) {
      _currentPage = currentPage;
      notifyListeners();
    }
  }

  void updateAtLastPage() {
    if (isLastPage) {
      _currentPage++;
      learningService.showConfetti();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _pageController.removeListener(_updatePage);
    _pageController.dispose();
    learningService.hideConffeti();
    super.dispose();
  }
}
