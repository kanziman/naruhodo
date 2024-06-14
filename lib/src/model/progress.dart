import 'package:naruhodo/src/model/voca.dart';

class Progress {
  final String level;
  final int totalCards;
  final int reviewedCards;
  final double percent;

  Progress({
    required this.level,
    required this.totalCards,
    required this.reviewedCards,
    required this.percent,
  });

  Map<String, dynamic> toMap() {
    return {
      'level': level,
      'totalCards': totalCards,
      'reviewedCards': reviewedCards,
      'percent': percent,
    };
  }

  static Progress fromVocas(
      String level, List<Voca> vocaList, List<Voca> reviewedList) {
    int totalCards = vocaList.length;
    int reviewedCards = reviewedList.length;
    double percent =
        totalCards == 0 ? 0 : (reviewedCards / totalCards).clamp(0.0, 1.0);
    return Progress(
      level: level,
      totalCards: totalCards,
      reviewedCards: reviewedCards,
      percent: percent,
    );
  }

  @override
  String toString() {
    return 'Progress(level: $level, totalCards: $totalCards, reviewedCards: $reviewedCards, percent: $percent)';
  }
}
