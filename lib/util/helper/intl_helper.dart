import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

abstract class IntlHelper {
  /// 지원 언어
  static const Locale en = Locale('en');
  static const Locale ko = Locale('ko');
  static const Locale ja = Locale('ja');

  /// 한국어 여부
  // static bool get isKo => Intl.getCurrentLocale() == ko.languageCode;
  // static bool get isEn => Intl.getCurrentLocale() == en.languageCode;
  static bool get isKo => Intl.getCurrentLocale() == ko.languageCode;
  static bool get isEn => Intl.getCurrentLocale() == en.languageCode;
  static bool get isJp => Intl.getCurrentLocale() == ja.languageCode;
  static String get getLang => Intl.getCurrentLocale();

  /// 통화
  static String currency({
    required String symbol,
    required int number,
  }) {
    return NumberFormat.currency(
      symbol: symbol,
      locale: (symbol == '￦' ? ko : en).languageCode,
    ).format(number);
  }
}
