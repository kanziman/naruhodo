import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/subject_type.dart';

class Content {
  final String? title;
  final String? desc;
  final SubjectType subjectType;
  final String? duration;
  final bool? random;
  final String? from;

  const Content({
    this.from,
    this.random,
    this.duration,
    this.title,
    this.desc,
    required this.subjectType,
  });

  Content.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        desc = map['desc'],
        subjectType = SubjectType.values
            .firstWhere((e) => e.toString() == map['subjectType']),
        duration = map['duration'],
        random = map['random'],
        from = map['from'];

  @override
  String toString() {
    return 'Content('
        'title: $title, '
        'desc: $desc, '
        'subjectType: $subjectType, '
        'duration: $duration, '
        'random: $random, '
        'from: $from, '
        ')';
  }

  static Icon getIcon(SubjectType subjectType) {
    const double size = 24.0;
    switch (subjectType) {
      case SubjectType.hiraganaTable:
      case SubjectType.katakanaTable:
      case SubjectType.hiragana:
      case SubjectType.katakana:
        return const Icon(Icons.directions_run, size: size);
      case SubjectType.hiraganaWord:
      case SubjectType.katakanaWord:
        return const Icon(Icons.electric_bike, size: size);

      case SubjectType.pattern:
        return const Icon(Icons.electric_bolt, size: size);

      case SubjectType.hiraganaSentence:
      case SubjectType.katakanaSentence:
        return const Icon(Icons.electric_car_outlined, size: size);
      case SubjectType.quiz:
        return const Icon(Icons.campaign, size: size);
      case SubjectType.voca:
      case SubjectType.review:
        return const Icon(Icons.workspace_premium_rounded, size: size);
    }
  }
}
