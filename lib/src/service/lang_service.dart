import 'package:flutter/material.dart';
import 'package:naruhodo/util/helper/intl_helper.dart';
import 'package:provider/provider.dart';

class LangService with ChangeNotifier {
  LangService({
    Locale? locale,
  }) : locale = locale ?? IntlHelper.en;

  Locale locale;

  void toggleLang() {
    locale = IntlHelper.isKo ? IntlHelper.en : IntlHelper.ko;
    // print('togglelang change $locale');
    notifyListeners();
  }
}

extension LangServiceExt on BuildContext {
  LangService get langService => watch<LangService>();
  Locale get locale => langService.locale;
}
