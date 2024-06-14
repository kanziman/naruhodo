import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/repository/voca_repository.dart';
import 'package:naruhodo/src/repository/word_repository.dart';

class LearningService extends ChangeNotifier {
  final WordRepository wordRepository;
  final VocaRepository vocaRepository;

  LearningService(
    this.wordRepository,
    this.vocaRepository,
  );

  bool isVisible = false;
  bool isPartiallyVisible = false;
  bool isSwitchOn = false;
  bool isShowConfetti = false;

  void toggleSwtich() {
    isSwitchOn = !isSwitchOn;
  }

  void resetVisibilityState() {
    isVisible = false;
    isPartiallyVisible = false;
    hideConffeti();
  }

  void showConfetti() {
    isShowConfetti = true;
  }

  void hideConffeti() {
    isShowConfetti = false;
  }

  void toggleVisibility() {
    if (!isPartiallyVisible) {
      isPartiallyVisible = true;
    } else if (!isVisible) {
      isVisible = true;
    } else {
      isVisible = false;
      isPartiallyVisible = false;
    }
    notifyListeners();
  }

  QueryRequest? _currentQueryRequest;
  QueryRequest? get currentQueryRequest => _currentQueryRequest;
  void setQueryRequest(QueryRequest queryRequest) {
    QueryRequest query = QueryRequest(
      subjectType: queryRequest.subjectType,
      topic: queryRequest.topic ?? 'topic',
      from: queryRequest.from,
    );

    _currentQueryRequest = query;
  }

  Future<List<dynamic>> load({useCache}) async {
    // useCache가 null인 경우 캐시 확인
    useCache = useCache ?? currentQueryRequest!.checkAndUpdateCache();
    QueryRequest newQueryRequest =
        currentQueryRequest!.copyWith(useCache: useCache);
    _currentQueryRequest = newQueryRequest;

    switch (currentQueryRequest!.subjectType) {
      case SubjectType.hiragana:
      case SubjectType.katakana:
        return wordRepository.readForAlphabetRandom(currentQueryRequest!);
      case SubjectType.hiraganaTable:
      case SubjectType.katakanaTable:
        return wordRepository.readForAlphabet(currentQueryRequest!);
      case SubjectType.hiraganaWord:
      case SubjectType.katakanaWord:
        return wordRepository.readForWordRandom(currentQueryRequest!);
      case SubjectType.hiraganaSentence:
      case SubjectType.katakanaSentence:
      case SubjectType.quiz:
        return wordRepository.readForQuizRandom(currentQueryRequest!);
      case SubjectType.pattern:
        return wordRepository.readForPattern(currentQueryRequest!);
      case SubjectType.voca:
        return vocaRepository.readForVoca(currentQueryRequest!);
      case SubjectType.review:
        return [];
    }
  }
}
