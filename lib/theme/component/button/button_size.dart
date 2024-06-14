part of 'button.dart';

/// 버튼 크기
enum ButtonSize {
  xsmall,
  small,
  medium,
  large,
  xlarge;

  double get padding {
    switch (this) {
      case ButtonSize.xsmall:
        return 4;

      case ButtonSize.small:
        return 8;
      case ButtonSize.medium:
        return 12;
      case ButtonSize.large:
      case ButtonSize.xlarge:
        return 16;
    }
  }

  TextStyle getTextStyle(BuildContext context) {
    switch (this) {
      case ButtonSize.xsmall:
        return context.typo.desc3;
      case ButtonSize.small:
        return context.typo.desc2;
      case ButtonSize.medium:
        return context.typo.desc1;
      case ButtonSize.large:
        return context.typo.headline5;
      case ButtonSize.xlarge:
        return context.typo.headline2;
    }
  }
}
