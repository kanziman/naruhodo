import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';

class QuizBoxText extends StatelessWidget {
  final String full;
  final String parts;
  final bool isVisible;

  const QuizBoxText({
    super.key,
    required this.full,
    required this.parts,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    // print('full $full');
    // print('parts $parts');
    List<InlineSpan> spans = [];
    int start = 0;
    List<String> partList = parts.split(',');

    while (start < full.length) {
      int nextStart = full.length; // 가장 작은 다음 시작점을 찾기 위한 변수

      for (String part in partList) {
        part = part.clean();
        final startIndex = full.indexOf(part, start);

        if (startIndex != -1 && startIndex < nextStart) {
          // 일치하는 부분이 있고 현재 확인중인 시작점보다 더 앞에 있는 경우
          if (startIndex > start) {
            // 일치하기 전까지의 텍스트를 추가합니다.
            spans.add(TextSpan(
              text: full.substring(start, startIndex),
              style: context.typo.headline3,
            ));
          }

          // 일치하는 텍스트에 스타일을 적용합니다.
          spans.add(TextSpan(
            text: full.substring(startIndex, startIndex + part.length),
            style: isVisible
                ? context.typo.headline3.copyWith(
                    // backgroundColor: context.color.hint,
                    color: context.color.quaternary,
                    // decoration: TextDecoration.underline,
                    decorationColor: context.color.quaternary,
                    decorationThickness: 0.5,
                  )
                : context.typo.headline3.copyWith(
                    color: Colors.transparent,
                    decoration: TextDecoration.underline,
                    decorationColor: context.color.text,
                    decorationThickness: 0.5,
                  ),
          ));
          nextStart = startIndex + part.length; // 다음 텍스트 검색 시작 위치 업데이트
        }
      }

      if (nextStart == full.length) {
        // 더 이상 일치하는 부분이 없을 때
        spans.add(TextSpan(
          text: full.substring(start),
          style: context.typo.headline3,
        ));
        break;
      }

      start = nextStart; // 다음 검색을 위해 start 업데이트
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
            children: spans, style: DefaultTextStyle.of(context).style),
      ),
    );
  }

  TextStyle adjustBaseline(TextStyle originalStyle, double heightFactor) {
    return originalStyle.copyWith(height: heightFactor);
  }

  // @override
  // Widget build(BuildContext context) {
  //   // List<Widget> textWidgets = [];
  //   List<InlineSpan> spans = [];
  //   print('full $full');
  //   print('part $part');
  //   int start = 0;

  //   while (start < full.length) {
  //     final startIndex = full.indexOf(part, start);
  //     if (startIndex == -1) {
  //       // 더 이상 일치하는 부분이 없으면 남은 텍스트를 추가하고 반복을 종료합니다.
  //       spans.add(TextSpan(
  //         text: full.substring(start),
  //         style: context.typo.headline3,
  //       ));
  //       break;
  //     } else {
  //       // 일치하기 전까지의 텍스트를 추가합니다.
  //       if (startIndex > start) {
  //         spans.add(TextSpan(
  //           text: full.substring(start, startIndex),
  //           style: context.typo.headline3,
  //         ));
  //       }

  //       int endIndex = startIndex + part.length;
  //       // part 다음에 바로 괄호가 오는지 확인합니다.
  //       spans.add(WidgetSpan(child: SizedBox(width: 2)));
  //       if (endIndex < full.length && full[endIndex] == '（') {
  //         int closeParenIndex = full.indexOf('）', endIndex);
  //         if (closeParenIndex != -1) {
  //           endIndex = closeParenIndex + 1; // 닫는 괄호를 포함합니다.
  //         }
  //       }

  //       // 일치하는 텍스트 및 괄호 내의 텍스트에 스타일을 적용합니다.
  //       spans.add(TextSpan(
  //         text: full.substring(startIndex, endIndex),
  //         style: isVisible
  //             ? context.typo.headline3.copyWith(
  //                 backgroundColor: context.color.inactive, // 배경색을 지정
  //                 color: context.color.onInactiveContainer, // 글자색을 지정
  //               )
  //             : context.typo.headline3.copyWith(
  //                 backgroundColor: context.color.inactive,
  //                 color: Colors.transparent, // 텍스트를 완전히 숨깁니다.
  //               ),
  //       ));
  //       spans.add(WidgetSpan(child: SizedBox(width: 2)));
  //       start = endIndex;
  //     }
  //   }

  //   return Padding(
  //     padding: const EdgeInsets.all(8.0),
  //     child: RichText(
  //       text: TextSpan(
  //           children: spans, style: DefaultTextStyle.of(context).style),
  //     ),
  //   );
  // }
}
