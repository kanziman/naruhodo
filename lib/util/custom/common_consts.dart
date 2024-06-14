import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

const String ENC_KEY = "SecurityKeyThis!SecurityKeyThis!";
const int CARDNUM = 10;

class Custom {
  static BoxDecoration contentBoxDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.color.surface,
      borderRadius: BorderRadius.circular(10),
      boxShadow: context.deco.shadowLight,
    );
  }
}
