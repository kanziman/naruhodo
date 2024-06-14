import 'dart:async';
import 'dart:developer';
import 'dart:math' as m;

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeakService extends ChangeNotifier {
  final SpeechToText _speech = SpeechToText();
  Timer? _firstSpeechTimer;
  Timer? _inactivityTimer;

  /// 변수
  String _wordsSpoken = "";
  double _level = 30.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  bool _speechEnabled = false;
  bool _isListening = false;
  bool _isSnackbarShown = false;
  bool _isPreparing = false;

  /// GETTER
  bool get isPreparing => _isPreparing;
  bool get speechEnabled => _speechEnabled;
  bool get isListening => _isListening;
  String get wordSpoken => _wordsSpoken;
  double get level => _level;
  bool get isSnackbarShown => _isSnackbarShown;
  void Function()? hideSnackbar;

  set isPreparing(bool value) {
    _isPreparing = value;
    notifyListeners();
  }

  void updateSpeechEnabled(bool enabled) {
    _speechEnabled = enabled;
    notifyListeners();
  }

  void updateWordsSpoken(String words) {
    _wordsSpoken = words;
    notifyListeners();
  }

  void updateSnackbarShown(bool isShown) {
    _isSnackbarShown = isShown;
    notifyListeners();
  }

  Future<void> initSpeech() async {
    _speechEnabled = await _speech.initialize(
      onError: (val) => log('Error: $val'),
      onStatus: (val) => log('Status: $val'),
    );
    _isListening = !_speechEnabled;
  }

  void _onSpeechResult(result) async {
    if (result.recognizedWords.isNotEmpty) {
      _firstSpeechTimer?.cancel(); // 첫 번째 말이 감지되면 첫 번째 타이머 취소
      _resetInactivityTimer(); // 묵음 감지 타이머 시작
    }

    _wordsSpoken = "${result.recognizedWords}";
    _isListening = _speech.isListening;
    notifyListeners();
  }

  void _startListening() async {
    try {
      if (_speechEnabled && !_speech.isListening) {
        await _speech.listen(
            onResult: _onSpeechResult,
            onSoundLevelChange: soundLevelListener,
            localeId: 'ja-JP');
      }
      _isListening = true;
      _isPreparing = false;
      _resetFirstSpeechTimer();
      notifyListeners();
    } catch (e) {
      log('Error starting to listen: $e');
    }
  }

  void _resetFirstSpeechTimer() {
    _firstSpeechTimer?.cancel();
    _firstSpeechTimer = Timer(const Duration(seconds: 3), () {
      if (!_speech.isListening) {
        _stopListening();
      }
    });
  }

  void _resetInactivityTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(const Duration(seconds: 1), () {
      if (_speech.isListening) {
        _stopListening();
      }
    });
  }

  void _stopListening() async {
    _firstSpeechTimer?.cancel();
    _inactivityTimer?.cancel();
    await _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  void toggleListen() {
    log('service: _isPreparing $_isPreparing, _isListening $_speech.isListening');

    // Check if already preparing or transitioning between states
    if (_isPreparing) {
      log('Ignore toggleListen as it is already preparing');
      return;
    }

    /// reset
    updateWordsSpoken("");
    updateSnackbarShown(false);

    // start
    if (!_speech.isListening) {
      log('Starting to listen');
      _isPreparing = true;
      notifyListeners();
      _startListening();
    } else {
      log('Stopping listening');
      _isPreparing = false;
      notifyListeners();
      _stopListening();
    }
  }

  void soundLevelListener(double level) {
    minSoundLevel = m.min(minSoundLevel, level);
    _level = level;
    notifyListeners();
  }

  void isSuccessSnack(isAnswer, context) {
    if (!_isSnackbarShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final snackBar = SnackBar(
          elevation: 0,
          showCloseIcon: false,
          duration: const Duration(milliseconds: 2222),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: isAnswer ? S.current.correct : S.current.incorrect,
            message: isAnswer ? S.current.correctSub : S.current.incorrectSub,
            contentType: isAnswer
                ? ContentType.success
                : ContentType.failure, // 정답을 맞췄으므로 success로 설정
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);

        // Toast.show(isAnswer ? '정답입니다!' : '틀렸습니다!');
        updateSnackbarShown(true);
      });
    }
  }
}
