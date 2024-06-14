import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';

enum CardSize {
  small,
  medium,
  large,
  xlarge;

  double get padding {
    switch (this) {
      case CardSize.small:
        return 8;
      case CardSize.medium:
        return 12;
      case CardSize.large:
        return 16;
      case CardSize.xlarge:
        return 12;
    }
  }

  double get margin {
    switch (this) {
      case CardSize.small:
        return 64;
      case CardSize.medium:
        return 64;
      case CardSize.large:
      case CardSize.xlarge:
        return 8;
    }
  }

  Text getTitleText(BuildContext context, String text) {
    return Text(text,
        style: context.typo.large.copyWith(
          fontWeight: context.typo.regular,
        ));
  }

  Widget getColorText(BuildContext context, String part, String full) {
    if (full.contains(part)) {
      final index = full.indexOf(part);
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: full.substring(0, index),
              style: context.typo.headline3,
            ),
            TextSpan(
              text: part,
              style: context.typo.headline3
                  .copyWith(color: context.color.quaternary),
            ),
            TextSpan(
              text: full.substring(index + part.length),
              style: context.typo.headline3,
            ),
          ],
        ),
      );
    } else if (full.contains(part.substring(0, part.length - 1))) {
      final index = full.indexOf(part.substring(0, part.length - 1));
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: full.substring(0, index),
              style: context.typo.headline3,
            ),
            TextSpan(
              text: part.substring(0, part.length - 1),
              style: context.typo.headline3
                  .copyWith(color: context.color.quaternary),
            ),
            TextSpan(
              text: full.substring(index + part.length - 1),
              style: context.typo.headline3,
            ),
          ],
        ),
      );
    } else if (full.contains(part.substring(0, part.length - 2))) {
      final index = full.indexOf(part.substring(0, part.length - 2));
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: full.substring(0, index),
              style: context.typo.headline3,
            ),
            TextSpan(
              text: part.substring(0, part.length - 2),
              style: context.typo.headline3
                  .copyWith(color: context.color.quaternary),
            ),
            TextSpan(
              text: full.substring(index + part.length - 2),
              style: context.typo.headline3,
            ),
          ],
        ),
      );
    }
    return Text(full, style: context.typo.headline3);
  }

  Text getText(BuildContext context, String text) {
    switch (this) {
      case CardSize.small:
        return Text(text, style: context.typo.headline5);
      case CardSize.medium:
        return Text(text, style: context.typo.headline3);
      case CardSize.large:
        return Text(text, style: context.typo.headline3);
      case CardSize.xlarge:
        return Text(text, style: context.typo.xLarge);
    }
  }

  Widget getDifferencesHighlightedText(
      BuildContext context, String spoken, String answer, TextStyle style) {
    List<InlineSpan> spanList = [];

    String spokenText = spoken.clean();
    String cleanCompare = answer.exInsideParentheses().clean();
    // print(spokenText);
    // print(cleanCompare);

    // 문자열을 한 문자씩 비교하며, 다른 부분을 찾아낸다
    for (int i = 0; i < spokenText.length; i++) {
      if (i < cleanCompare.length && spokenText[i] == cleanCompare[i]) {
        spanList.add(TextSpan(text: spokenText[i], style: style)); // 일치하는 부분
      } else {
        spanList.add(TextSpan(
          text: spokenText[i],
          style: style.copyWith(
            color: context.color.secondary.withOpacity(0.8),
          ), // 일치하지 않는 부분은 빨간색으로 표시
        ));
      }
    }

    return RichText(
        text: TextSpan(
            children: spanList, style: DefaultTextStyle.of(context).style));
  }

  Widget getBoxText(BuildContext context, String text, String textCompare) {
    switch (this) {
      case CardSize.small:
        return Container(
          padding: const EdgeInsets.all(8), // 내부 여백을 추가합니다.
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5), // 박스의 배경색을 설정합니다.
          ),
          child: getDifferencesHighlightedText(
              context, text, textCompare, context.typo.xLarge),
        );
      case CardSize.medium:
        return Container(
          padding: const EdgeInsets.all(8), // 내부 여백을 추가합니다.
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5), // 박스의 배경색을 설정합니다.
          ),
          child: getDifferencesHighlightedText(
              context, text, textCompare, context.typo.headline1),
        );
      case CardSize.large:
      case CardSize.xlarge:
        return Container(
          padding: const EdgeInsets.all(8), // 내부 여백을 추가합니다.
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.5), // 박스의 배경색을 설정합니다.
          ),
          child: getDifferencesHighlightedText(
            context,
            text,
            textCompare,
            context.typo.headline3,
          ),
        );
    }
  }

  Text getSubText(BuildContext context, String text) {
    switch (this) {
      case CardSize.small:
      case CardSize.medium:
        return Text(text,
            style: context.typo.headline3.copyWith(
              color: context.color.subtext,
            ));
      case CardSize.large:
        return Text(text,
            style: context.typo.headline6.copyWith(
              color: context.color.subtext,
            ));
      case CardSize.xlarge:
        return Text(text,
            style: context.typo.large.copyWith(
              color: context.color.subtext,
            ));
    }
  }
}
