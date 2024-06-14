import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/lang.dart';

class SectionContent {
  final Lang? title;
  final Lang? desc;
  final SubjectType subjectType;
  final Lang? duration;
  final bool? random;
  final String? from;
  final int? seq;

  const SectionContent({
    this.seq,
    this.from,
    this.random,
    this.duration,
    this.title,
    this.desc,
    required this.subjectType,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title?.toJson(),
      'desc': desc?.toJson(),
      'subjectType': subjectType.toString(),
      'from': from,
      'duration': duration,
      'random': random,
    };
  }

  factory SectionContent.fromJson(Map<String, dynamic> json) {
    SubjectType subjectType = SubjectType.values.firstWhere(
        (e) => e.toString().split('.').last == json['subjectType'],
        orElse: () => SubjectType.hiraganaWord);
    Lang? descLang;
    if (json['desc'] != null) {
      descLang = Lang.fromJson(json['desc'] as Map<String, dynamic>);
    }
    return SectionContent(
      title: Lang.fromJson(json['title'] as Map<String, dynamic>),
      desc: descLang,
      duration: Lang.fromJson(json['duration'] as Map<String, dynamic>),
      subjectType: subjectType,
      from: json['from'] ?? "",
      random: json['random'],
    );
  }

  @override
  String toString() {
    return 'SectionContent('
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
