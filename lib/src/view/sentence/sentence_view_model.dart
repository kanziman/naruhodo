import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/tts_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/view/base/base_view_model.dart';

class SentenceViewModel extends BaseViewModel {
  List<Word> wordList = [];
  late final LearningService learningService;
  late final TtsService ttsService;

  SentenceViewModel({
    required this.learningService,
    required this.ttsService,
  });

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
    wordList = results[0];

    isBusy = false;
  }
}
