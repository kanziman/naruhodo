// import 'package:flutter/material.dart';
// import 'package:naruhodo/src/enum/subject_type.dart';

// class Review {
//   final String? name;
//   final String? image;
//   final String title;
//   final String? desc;
//   final ReviewType reviewType;
//   final SubjectType subjectType;
//   final String? info;
//   final String? duration;
//   final String? random;
//   final String? from;
//   final String? category;

//   const Review({
//     this.category,
//     this.from,
//     this.random,
//     this.duration,
//     this.name,
//     this.image,
//     this.desc,
//     required this.title,
//     required this.reviewType,
//     required this.subjectType,
//     this.info,
//   });

//   static Icon getIcon(ReviewType subjectType) {
//     const double size = 24.0;
//     return const Icon(Icons.reviews, size: size);
//   }
// }

// enum ReviewType { n5, n4, n3 }


class Review {
  int totalCards;
  int reviewedCards;
  double percent;

  Review({
    required this.totalCards,
    required this.reviewedCards,
    required this.percent,
  });

  // Optionally, you can add a factory method for easier instantiation from a Map
  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      totalCards: map['totalCards'],
      reviewedCards: map['reviewedCards'],
      percent: map['percent'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalCards': totalCards,
      'reviewedCards': reviewedCards,
      'percent': percent,
    };
  }
}
