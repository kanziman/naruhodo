import 'package:audioplayers/audioplayers.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/tts_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/view/base/base_view_model.dart';

class PatternViewModel extends BaseViewModel {
  List<Word> wordList = [];
  late final LearningService learningService;
  late final TtsService ttsService;

  PatternViewModel({
    required this.learningService,
    required this.ttsService,
  });

  List<Word> explanations = [];
  List<Word>? explanationDesc;
  List<Word> patterns = [];
  List<Word> vocas = [];

  final AudioPlayer _audioPlayer = AudioPlayer();
  void playAudio(url) async {
    await _audioPlayer.play(UrlSource(url));
  }

  Future<void> refreshData() async {
    await loadData(useCache: false);
  }

  Future<void> loadData({useCache}) async {
    isBusy = true;
    ttsService.changeTtsNormal();

    final results = await Future.wait([
      learningService.load(useCache: useCache),
      Future.delayed(const Duration(milliseconds: 555)),
    ]);
    wordList = results[0];

    /// 설명
    explanationDesc = wordList
        .where((word) => word.topic.contains('desc'))
        .toList()
      ..sort((a, b) => a.seq!.compareTo(b.seq!));

    /// 설명 문장
    explanations = wordList.where((word) => word.topic.contains('exp')).toList()
      ..sort((a, b) => a.seq!.compareTo(b.seq!));

    /// 패턴 문장
    patterns = wordList
        .where((word) =>
            !word.topic.contains('exp') &&
            !word.topic.contains('word') &&
            !word.topic.contains('desc'))
        .toList()
      ..sort((a, b) => a.seq!.compareTo(b.seq!));

    /// 패턴 단어
    vocas = wordList.where((word) => word.topic.contains('word')).toList()
      ..sort((a, b) => a.seq!.compareTo(b.seq!));

    isBusy = false;
  }
}
