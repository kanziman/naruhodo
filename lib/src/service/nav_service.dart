import 'package:flutter/material.dart';

class NavService extends ChangeNotifier {
  /// PAGE
  int navPage = 0;
  void updateNavPage(int value) {
    navPage = value;
    notifyListeners();
  }
}
