import 'lang.dart';

class Voca {
  const Voca(
      {required this.id,
      required this.topic,
      required this.category,
      required this.voca,
      required this.expression,
      this.vocaMean,
      this.type,
      this.meaning,
      this.quiz,
      this.seq,
      this.nextReview,
      this.lastReview,
      this.isSelected,
      this.voice});

  final String id;
  final String topic;
  final String category;
  final String voca;
  final String expression;
  final String? type;
  final Lang? vocaMean;
  final Lang? meaning;
  final Lang? quiz;
  final int? seq;
  final DateTime? nextReview;
  final DateTime? lastReview;
  final bool? isSelected;
  final Map<String, dynamic>? voice;

  factory Voca.fromJson(String id, Map<String, dynamic> json) {
    return Voca(
      id: id,
      topic: json['topic'],
      category: json['category'],
      voca: json['voca'],
      type: json['type'] ?? '',
      expression: json['expression'] ?? '',
      vocaMean: Lang.fromJson(json['vocaMean'] ?? {}),
      meaning: Lang.fromJson(json['meaning'] ?? {}),
      quiz: Lang.fromJson(json['quiz'] ?? {}),
      seq: json['seq'] ?? 0,
      nextReview: json['nextReview'] != null
          ? DateTime.parse(json['nextReview']).toLocal()
          : null,
      lastReview: json['lastReview'] != null
          ? DateTime.parse(json['lastReview']).toLocal()
          : null,
      voice: json['voice'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'category': category,
      'voca': voca,
      'expression': expression,
      'type': type,
      'vocaMean': vocaMean?.toJson(),
      'meaning': meaning?.toJson(),
      'quiz': quiz?.toJson(),
      'seq': seq,
      'nextReview': nextReview?.toUtc().toIso8601String(),
      'lastReview': lastReview?.toUtc().toIso8601String(),
      'voice': voice,
    };
  }

  @override
  String toString() {
    // return '''
    //   Voca(
    //     id: $id,

    //   )''';
    return '''
      Voca(
        id: $id,
        topic: $topic,
        category: $category,
        voca: $voca,
        type: $type,
        expression: $expression,
        vocaMean: $vocaMean,
        meaning: $meaning,
        quiz: $quiz,
        lastReview: $lastReview,
        seq: $seq
      )''';
  }
}
