import 'package:flutter/material.dart';

import 'foundation/app_theme.dart';
import 'res/palette.dart';
import 'res/typo.dart';

class LightTheme implements AppTheme {
  @override
  Brightness brightness = Brightness.light;

  @override
  AppColor color = AppColor(
    surface: Palette.grey100,
    onSurface: Palette.white,
    background: Palette.black.withOpacity(0.55),
    text: Palette.black,
    subtext: Palette.grey700,
    toastContainer: Palette.black.withOpacity(0.85),
    onToastContainer: Palette.grey100,
    hint: Palette.grey300,
    hintContainer: Palette.grey150,
    onHintContainer: Palette.grey500,
    inactive: Palette.grey400,
    inactiveContainer: Palette.grey250,
    onInactiveContainer: Palette.white,
    primary: Palette.green,
    onPrimary: Palette.white,
    secondary: Palette.red,
    onSecondary: Palette.white,
    tertiary: Palette.yellow,
    onTertiary: Palette.white,
    quaternary: Palette.orange,
    onQuaternary: Palette.white,
    quinary: Palette.blue,
    onQuinary: Palette.white,
    senary: Palette.navy,
    onSenary: Palette.white,
    septenary: Palette.purple,
    onSeptenary: Palette.white,
  );

  @override
  late AppTypo typo = AppTypo(
    typo: const NotoSans(),
    fontColor: color.text,
  );

  @override
  AppDeco deco = AppDeco(
    shadow: [
      BoxShadow(
        color: Palette.black.withOpacity(0.1),
        blurRadius: 35,
      ),
    ],
    shadowLight: [
      BoxShadow(
        color: Palette.black.withOpacity(0.1),
        blurRadius: 5,
      ),
    ],
  );
}
