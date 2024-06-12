import 'dart:convert';

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/repository/word_repository.dart';

import '../dummy_request.dart';
import '../dummy_word.dart';

// 더미 데이터를 Firestore에 추가하는 함수
Future<void> setupFakeFirestoreData(FakeFirebaseFirestore firestore) async {
  List<dynamic> wordList = json.decode(Dummy.jsonWordList);
  for (var word in wordList) {
    await firestore.collection('word').add(word);
  }
  List<dynamic> alphabetList = json.decode(Dummy.jsonAlphabetList);
  for (var alphabet in alphabetList) {
    await firestore.collection('alphabet').add(alphabet);
  }
  // patternsCollection에 데이터 추가
  List<dynamic> patternList = json.decode(Dummy.jsonPatternList);
  for (var pattern in patternList) {
    await firestore
        .collection('patterns')
        .doc('pattern')
        .collection(pattern['topic'])
        .add(pattern);
  }

  // // Firestore 데이터 출력
  // final snapshot = await firestore.collection('word').get();
  // for (var doc in snapshot.docs) {
  //   log('doc: $doc.data()');
  // }
}

void main() {
  late WordRepository wordRepository;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();
    await setupFakeFirestoreData(fakeFirestore);
    wordRepository = WordRepository(firestore: fakeFirestore);
  });

  group('WordRepository', () {
    group('fetchData()', () {
      test('통신 성공시 List<Word>를 반환한다.', () async {
        QueryRequest queryRequest = DummyRequest.DummyQueryRequestWord;

        final results = await wordRepository.fetchData(
          query: wordRepository.getQuery(queryRequest),
          useCache: queryRequest.useCache!,
        );

        expect(results.isNotEmpty, true);
        expect(results.length, 2);
        expect(results[0].character, 'き');
        expect(results[1].character, 'あかちゃん');
      });
      test('통신 실패시 []을 던진다.', () async {
        final failingQuery =
            fakeFirestore.collection('non_existent_collection');

        final results = await wordRepository.fetchData(
            query: failingQuery, useCache: false);
        expect(results, []);
      });
    });

    group('alphabetCollection', () {
      test('성공시 알파벳 데이터를 반환한다.', () async {
        QueryRequest queryRequest = DummyRequest.DummyQueryRequestAlphabet;
        final results = await wordRepository.readForAlphabet(queryRequest);

        expect(results.isNotEmpty, true);
        expect(results[results.length - 1].character, 'お');
      });

      test('랜덤으로 카드를 추출한다.', () {
        List<int> testList = List.generate(10, (index) => index);
        List<int> randomizedList = wordRepository.randomElements(testList, 5);

        expect(randomizedList.length, 5);
        expect(randomizedList, isNot(orderedEquals(testList.sublist(0, 5))));
      });
    });

    group('patternsCollection', () {
      test('패턴조회시 패턴 데이터를 반환한다.', () async {
        QueryRequest queryRequest = DummyRequest.DummyQueryRequestPattern;
        final results = await wordRepository.readForPattern(queryRequest);

        expect(results.isNotEmpty, true);
      });
      test('퀴즈조회시 복수 패턴 데이터가 조회된다.', () async {
        QueryRequest queryRequest = DummyRequest.DummyQueryRequestQuiz;

        final results = await wordRepository.readForQuizRandom(queryRequest);
        // '001'에 대한 데이터 필터링
        List<Word> results001 = results.where((e) => e.topic == '001').toList();
        // '002'에 대한 데이터 필터링
        List<Word> results002 = results.where((e) => e.topic == '002').toList();

        // '001'에 대한 데이터 조회
        expect(results001.length, 2);
        expect(results001[0].topic, '001');
        // '002'에 대한 데이터 조회
        expect(results002.length, 2);
        expect(results002[0].topic, '002');
      });
    });
  });
}
