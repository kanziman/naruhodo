import 'package:naruhodo/util/helper/intl_helper.dart';

class Lang {
  final String ko;
  final String en;

  const Lang({
    required this.ko,
    required this.en,
  });

  factory Lang.fromJson(Map<String, dynamic> json) {
    return Lang(
      ko: json['ko'] ?? '',
      en: json['en'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ko': ko.toString(),
      'en': en.toString(),
    };
  }

  @override
  String toString() => IntlHelper.isKo ? ko : en;
  // String toString() => IntlHelper.getLang;
}
