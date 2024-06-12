import 'package:naruhodo/src/model/lang.dart';
import 'package:naruhodo/src/model/voca.dart';

abstract class DummyVoca {
  static const Voca dummyVoca1 = Voca(
    id: 'gCng86jEU3yPiToHAWqM',
    topic: 'N4',
    category: 'Food',
    voca: '味(あじ)',
    type: 'noun',
    expression: 'このスープの味がとても良(よ)いです。',
    vocaMean: Lang(ko: '맛', en: 'taste'),
    meaning: Lang(
        ko: '이 수프의 맛이 매우 좋습니다.', en: 'The taste of this soup is very good.'),
    quiz: Lang(ko: '맛', en: 'taste'),
  );

  static const Voca dummyVoca2 = Voca(
    id: 'hDmb97kFG4yQiTpIBXrN',
    topic: 'N4',
    category: 'Animals',
    voca: '猫(ねこ)',
    type: 'noun',
    expression: '私(わたし)の家(いえ)に猫(ねこ)がいます。',
    vocaMean: Lang(ko: '고양이', en: 'cat'),
    meaning: Lang(ko: '우리 집에 고양이가 있습니다.', en: 'There is a cat in my house.'),
    quiz: Lang(ko: '고양이', en: 'cat'),
  );

  static const String jsonVocaList = '''[
    {
      "id": "gCng86jEU3yPiToHAWqM",
      "topic": "N4",
      "category": "Food",
      "voca": "味(あじ)",
      "type": "noun",
      "expression": "このスープの味がとても良(よ)いです。",
      "vocaMean": {"ko": "맛", "en": "taste"},
      "meaning": {"ko": "이 수프의 맛이 매우 좋습니다.", "en": "The taste of this soup is very good."},
      "quiz": {"ko": "맛", "en": "taste"}
    },
    {
      "id": "hDmb97kFG4yQiTpIBXrN",
      "topic": "N3",
      "category": "Animals",
      "voca": "猫(ねこ)",
      "type": "noun",
      "expression": "私(わたし)の家(いえ)に猫(ねこ)がいます。",
      "vocaMean": {"ko": "고양이", "en": "cat"},
      "meaning": {"ko": "우리 집에 고양이가 있습니다.", "en": "There is a cat in my house."},
      "quiz": {"ko": "고양이", "en": "cat"}
    }
  ]''';
}
