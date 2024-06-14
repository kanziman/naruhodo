part of 'app_theme.dart';

class AppTypo {
  AppTypo({
    required this.typo,
    required this.fontColor,
  });

  /// Typo
  final Typo typo;

  /// Font Weight
  late FontWeight light = typo.light;
  late FontWeight regular = typo.regular;
  late FontWeight semiBold = typo.semiBold;

  /// Font Color
  final Color fontColor;

  /// Title
  late final TextStyle large = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 36,
    color: fontColor,
  );
  late final TextStyle xLarge = TextStyle(
    height: 1.5,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 60,
    color: fontColor,
  );
  late final TextStyle xxLarge = TextStyle(
    height: 1.5,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 72,
    color: fontColor,
  );
  late final TextStyle xxxLarge = TextStyle(
    height: 1.5,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 84,
    color: fontColor,
  );

  /// Headline
  late final TextStyle headline1 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 28,
    color: fontColor,
  );
  late final TextStyle headline2 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 24,
    color: fontColor,
  );
  late final TextStyle headline3 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 21,
    color: fontColor,
  );
  late final TextStyle headline4 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 20,
    color: fontColor,
  );
  late final TextStyle headline5 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 19,
    color: fontColor,
  );
  late final TextStyle headline6 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 18,
    color: fontColor,
  );
  late final TextStyle headline7 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 17,
    color: fontColor,
  );
  late final TextStyle headline8 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 16,
    color: fontColor,
  );

  /// desc
  late final TextStyle desc1 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 16,
    color: fontColor,
  );
  late final TextStyle desc2 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 15,
    color: fontColor,
  );
  late final TextStyle desc3 = TextStyle(
    height: 1.2,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 13,
    color: fontColor,
  );

  /// Body
  late final TextStyle body1 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 14,
    color: fontColor,
  );
  late final TextStyle body2 = TextStyle(
    height: 1.3,
    fontFamily: typo.name,
    fontWeight: typo.regular,
    fontSize: 12,
    color: fontColor,
  );

  // special case

  late final TextStyle quizStyle = TextStyle(
    height: 2,
    fontFamily: typo.name,
    fontWeight: typo.semiBold,
    fontSize: 19,
    color: fontColor,
  );
}
