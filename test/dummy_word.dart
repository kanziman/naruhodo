import 'package:naruhodo/src/model/lang.dart';
import 'package:naruhodo/src/model/word.dart';

abstract class Dummy {
  static const Word dummyWord1 = Word(
    topic: 'hiragana_word',
    character: 'き',
    meaning: Lang(ko: '나무', en: 'tree'),
    sound: Lang(ko: '키', en: 'ki'),
    answer: '',
    quiz: '',
    pattern: null,
    voice: null,
    seq: 0,
  );

  static const Word dummyWord2 = Word(
    topic: 'hiragana_word',
    character: 'あかちゃん',
    meaning: Lang(ko: '아기', en: 'baby'),
    sound: Lang(ko: '아카짱', en: 'akachan'),
    answer: '',
    quiz: '',
    pattern: null,
    voice: null,
    seq: 1,
  );

  static const String jsonWordList = '''[
    {
      "topic": "hiragana_word",
      "character": "き",
      "pattern": null,
      "meaning": {
        "ko": "나무",
        "en": "tree"
      },
      "sound": {
        "ko": "키",
        "en": "ki"
      },
      "answer": "",
      "kanji": null,
      "quiz": "",
      "voice": null,
      "seq": 0
    },
    {
      "topic": "hiragana_word",
      "character": "あかちゃん",
      "pattern": null,
      "meaning": {
        "ko": "아기",
        "en": "baby"
      },
      "sound": {
        "ko": "아카짱",
        "en": "akachan"
      },
      "answer": "",
      "kanji": null,
      "quiz": "",
      "voice": null,
      "seq": 1
    }
  ]
  ''';

  static const String jsonAlphabetList = '''[
  {
    "topic": "hiragana",
    "sound": {
      "ko": "아",
      "en": "a"
    },
    "romaji": "a",
    "character": "あ",
    "seq": 1
  },
  {
    "topic": "hiragana",
    "sound": {
      "ko": "이",
      "en": "i"
    },
    "romaji": "i",
    "character": "い",
    "seq": 2
  },
  {
    "topic": "hiragana",
    "sound": {
      "ko": "우",
      "en": "u"
    },
    "romaji": "u",
    "character": "う",
    "seq": 3
  },
  {
    "topic": "hiragana",
    "sound": {
      "ko": "에",
      "en": "e"
    },
    "romaji": "e",
    "character": "え",
    "seq": 4
  },
  {
    "topic": "hiragana",
    "sound": {
      "ko": "오",
      "en": "o"
    },
    "romaji": "o",
    "character": "お",
    "seq": 5
  }
]
''';

  static const String jsonPatternList = '''[
{
    "topic": "001",
    "pattern": "~だ",
    "meaning": { "ko": "그는 학생이다.", "en": "He is a student." },
    "answer": "彼(かれ)は学生(がくせい)だ。",
    "character": "かれはがくせいだ。",
    "sound": { "ko": "카레와 가쿠세-다", "en": "Kare wa gakusei da" }
  },
  {
    "topic": "001",
    "pattern": "~だ",
    "meaning": { "ko": "그녀는 화가다.", "en": "She is a painter." },
    "answer": "彼女(かのじょ)は画家(がか)だ。",
    "character": "かのじょはがかだ。",
    "sound": { "ko": "카노죠와 가카다", "en": "Kanojo wa gaka da" }
  },
   {
    "topic": "002",
    "pattern": "~だった",
    "meaning": { "ko": "나는 학생이었다.", "en": "I was a student." },
    "answer": "私(わたし)は学生(がくせい)だった。",
    "character": "わたしはがくせいだった。",
    "sound": { "ko": "와타시와 가쿠세이닷타", "en": "Watashi wa gakusei datta" }
  },
  {
    "topic": "002",
    "pattern": "~だった",
    "meaning": { "ko": "어제는 금요일이었다.", "en": "Yesterday was Friday." },
    "answer": "昨日(きのう)は金曜日(きんようび)だった。",
    "character": "きのうはきんようびだった。",
    "sound": { "ko": "키노우와 킨요-비닷타", "en": "Kinou wa kinyoubi datta" }
  }
]''';

  ///END
}
