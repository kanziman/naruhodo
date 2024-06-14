import 'package:naruhodo/src/enum/subject_type.dart';

class QueryRequest {
  final SubjectType subjectType;
  final String? topic;
  final String? orderBy;
  final String? from;
  final bool? useCache;
  static Map<String, DateTime> cacheCheckMap = {};

  const QueryRequest({
    required this.subjectType,
    this.useCache,
    this.topic,
    this.orderBy,
    this.from,
  });

  QueryRequest copyWith({
    SubjectType? subjectType,
    String? topic,
    String? orderBy,
    String? from,
    bool? useCache,
  }) {
    return QueryRequest(
      subjectType: subjectType ?? this.subjectType,
      topic: topic ?? this.topic,
      orderBy: orderBy ?? this.orderBy,
      useCache: useCache ?? this.useCache,
      from: from ?? this.from,
    );
  }

  // 캐시 확인 및 갱신 함수
  bool checkAndUpdateCache() {
    DateTime now = DateTime.now();
    String cacheKey = '$topic:$from';

    if (cacheCheckMap.containsKey(cacheKey)) {
      DateTime lastCallTime = cacheCheckMap[cacheKey]!;
      if (now.difference(lastCallTime).inMinutes < 5) {
        return true; // 캐시 사용
      } else {
        cacheCheckMap[cacheKey] = now; // 시간 갱신
        return false; // 캐시 사용 안함
      }
    } else {
      cacheCheckMap[cacheKey] = now; // 첫 호출 시간 기록
      return false; // 캐시 사용 안함
    }
  }

  String reName(String name) {
    return name.replaceAll("Table", "");
  }

  String camelCaseToUnderscore(String str) {
    // 대문자 앞에 언더스코어(_) 추가하고, 대문자를 소문자로 변환
    String underscoreStr = str.replaceAllMapped(
      RegExp(r'(?<=[a-z])[A-Z]'),
      (Match m) => '_${m.group(0)}'.toLowerCase(),
    );

    return underscoreStr;
  }

  @override
  String toString() {
    return 'QueryRequest(subject: ${subjectType.name}, topic: $topic, orderBy: $orderBy, useCache: $useCache, from: $from)';
  }
}
