import 'lang.dart';

class Word {
  const Word(
      {required this.topic,
      required this.character,
      this.pattern,
      this.meaning,
      this.sound,
      this.answer,
      this.kanji,
      this.quiz,
      this.seq,
      this.voice});

  final String topic;
  final String character;
  final String? pattern;
  final Lang? meaning;
  final Lang? sound;
  final String? answer;
  final String? kanji;
  final String? quiz;
  final Map<String, dynamic>? voice;
  final int? seq;

  factory Word.fromJson(Map<String, dynamic> json) {
    return Word(
      topic: json['topic'] ?? '',
      pattern: json['pattern'],
      character: json['character'] ?? '',
      meaning: Lang.fromJson(json['meaning'] ?? {}),
      sound: Lang.fromJson(json['sound'] ?? {}),
      answer: json['answer'] ?? '',
      quiz: json['quiz'] ?? '',
      kanji: json['kanji'],
      seq: json['seq'] ?? 0,
      voice: json['voice'] as Map<String, dynamic>?,
    );
  }

  @override
  String toString() {
    // 각 필드를 적절한 문자열로 변환하여 반환
    return 'Word(topic: $topic, character: $character, meaning: ${meaning.toString()}, sound: ${sound.toString()}, answer: $answer,quiz: $quiz, pattern: $pattern, voice: $voice, seq: $seq)';
  }
}
