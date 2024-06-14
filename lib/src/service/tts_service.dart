import 'dart:developer';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TtsService extends ChangeNotifier {
  final FlutterTts _tts = FlutterTts();
  double _speechRate = 0.5;
  double _pitch = Platform.isAndroid ? 1 : 1;
  bool _isSpeaking = false; // 음성 변환 중인지 여부

  TtsService() {
    _initializeTts();
    _tts.setCompletionHandler(() {
      _isSpeaking = false; // 음성 변환 완료 시
      notifyListeners(); // 상태 변경 알림
    });
  }

  bool get isSpeaking => _isSpeaking;
  double get speechRate => _speechRate;
  double get pitch => _pitch;

  set speechRate(double rate) {
    _speechRate = rate;
    _tts.setSpeechRate(rate);
    notifyListeners();
  }

  set pitch(double rate) {
    _pitch = rate;
    _tts.setPitch(rate);
    notifyListeners(); // 변경 알림
  }

  void changeTtsSlow() {
    log('changed to slow');
    Future.delayed(Duration.zero, () {
      speechRate = 0.3;
    });
  }

  void changeTtsNormal() {
    log('changed to normal $_speechRate');
    Future.delayed(Duration.zero, () {
      speechRate = Platform.isAndroid ? 0.55 : 0.53;
      // print('speechRate $speechRate');
    });
  }

  Future<void> _initializeTts() async {
    await _tts.setLanguage('ja-JP');
    await _tts.setSpeechRate(_speechRate);
    await _tts.setVolume(1.0);
    await _tts.setPitch(1);

    if (Platform.isIOS) {
      await _tts.setIosAudioCategory(IosTextToSpeechAudioCategory.playback, [
        IosTextToSpeechAudioCategoryOptions.allowBluetooth,
        IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
        IosTextToSpeechAudioCategoryOptions.mixWithOthers,
        IosTextToSpeechAudioCategoryOptions.defaultToSpeaker
      ]);
    }
  }

  Future<void> speak(String text) async {
    // print(_tts.getSpeechRateValidRange);
    _isSpeaking = true; // 음성 변환 시작 시
    notifyListeners(); // 상태 변경 알림
    await _tts.speak(text);
    // _tts.setCompletionHandler() 내에서 _isSpeaking을 false로 설정합니다.
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }
}
