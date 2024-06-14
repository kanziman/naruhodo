import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naruhodo/src/model/voca.dart';
import 'package:naruhodo/src/repository/voca_repository.dart';
import 'package:naruhodo/src/service/review_service.dart';

import '../dummy_voca.dart';

void main() {
  group('ReviewService', () {
    late ReviewService reviewService;
    List<Voca> vocaList = [];
    setUp(() {
      reviewService = ReviewService(
          vocaRepository: VocaRepository(firestore: FakeFirebaseFirestore()));

      vocaList.add(DummyVoca.dummyVoca1);
      vocaList.add(DummyVoca.dummyVoca2);
      reviewService.vocasMap = {
        'N4': vocaList,
      };
    });

    test('Voca 리뷰시 리뷰 카드수, 퍼센트가 업데이트된다.', () {
      const voca = DummyVoca.dummyVoca1;
      reviewService.addReview(voca);

      // reviewedListMap 검증
      expect(reviewService.reviewedListMap['N4'], isNotNull);
      expect(reviewService.reviewedListMap['N4']!.length, 1);

      // progressMap 검증
      expect(reviewService.progressMap['N4']!.reviewedCards, 1);
      expect(reviewService.progressMap['N4']!.percent, 0.5);
    });

    test('중복된 Voca 리뷰시 리뷰 카드수, 퍼센트가 업데이트되지 않는다.', () {
      const voca = DummyVoca.dummyVoca1;

      reviewService.addReview(voca);
      reviewService.addReview(voca);

      // reviewedListMap 검증
      expect(reviewService.reviewedListMap['N4'], isNotNull);
      expect(reviewService.reviewedListMap['N4']!.length, 1);

      // progressMap 검증
      expect(reviewService.progressMap['N4']!.reviewedCards, 1);
      expect(reviewService.progressMap['N4']!.percent, 0.5);
    });

    test('여러 Voca 리뷰시 리뷰 카드수, 퍼센트가 올바르게 업데이트된다.', () {
      const voca1 = DummyVoca.dummyVoca1;
      const voca2 = DummyVoca.dummyVoca2;

      reviewService.addReview(voca1);
      reviewService.addReview(voca2);

      // reviewedListMap 검증
      expect(reviewService.reviewedListMap['N4'], isNotNull);
      expect(reviewService.reviewedListMap['N4']!.length, 2);

      // progressMap 검증
      expect(reviewService.progressMap['N4']!.reviewedCards, 2);
      expect(reviewService.progressMap['N4']!.percent, 1.0);
    });
  });
}
