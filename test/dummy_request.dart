import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/query_request.dart';

abstract class DummyRequest {
  static const DummyQueryRequestAlphabet = QueryRequest(
    subjectType: SubjectType.hiraganaTable,
    topic: 'hiragana',
    useCache: false,
  );
  static const DummyQueryRequestWord = QueryRequest(
    subjectType: SubjectType.hiraganaWord,
    topic: 'Word',
    useCache: false,
  );
  static const DummyQueryRequestPattern = QueryRequest(
    subjectType: SubjectType.pattern,
    topic: '~だ',
    useCache: false,
    from: '001',
  );
  static const DummyQueryRequestQuiz = QueryRequest(
    subjectType: SubjectType.quiz,
    topic: 'QUIZ',
    useCache: false,
    from: '001,002',
  );
}
