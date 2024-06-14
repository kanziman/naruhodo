import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/round_container.dart';
import 'package:naruhodo/src/widgets/tts/tts_button.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/util/custom/extensions.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';

class RowCard extends StatelessWidget {
  const RowCard({
    super.key,
    required this.word,
    double? paddingInside,
    bool? isDirectionRow,
  })  : paddingInside = paddingInside ?? 16,
        isDirectionRow = isDirectionRow ?? true;

  // final Product product;
  final Word word;
  final double paddingInside;
  final bool isDirectionRow;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      // padding: EdgeInsets.symmetric(
      //     horizontal: paddingInside, vertical: paddingInside / 2),
      decoration: BoxDecoration(
        color: context.color.surface,
        boxShadow: context.deco.shadowLight,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: paddingInside, vertical: paddingInside),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isDirectionRow ? cardRow(context) : cardColumn(context),
              ],
            ),
          ),
        ),
        Positioned(
          right: 5,
          bottom: 5,
          child: RoundContainer(
            bgColor: context.color.hint,
            size: 36,
            child: TtsButton(
              onPressed: (){},
              size: ButtonSize.xsmall,
              character: word.kanji != null
                  ? word.kanji!
                  : word.character.exInsideParentheses(),
            ),
          ),
          // TtsButton(
          //   character: word.character.exInsideParentheses().replaceAll('~', ''),
          //   size: 18,
          // ),
        ),
      ]),
    );
  }

  /// 가로
  Widget cardRow(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                word.meaning.toString(),
                style: context.typo.body1,
              ),
            ),
            SizedBox(
              height: 3.5.h,
              child: VerticalDivider(
                color: context.color.hint,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 2,
              child: (word.pattern != null && !word.topic.contains('exp'))
                  ? patternText(context)
                  : normalText(context),
            ),
          ],
        ),
      ],
    );
  }

  /// 세로
  Widget cardColumn(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬을 위해
          children: [
            Text(
              word.meaning.toString(),
              style: context.typo.body1,
            ),
            const SizedBox(height: 8), // 세로 간격 조정
            Divider(
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 8), // 세로 간격 조정

            (word.pattern != null && !word.topic.contains('exp'))
                ? patternText(context)
                : normalText(context),
          ],
        ),
      ],
    );
  }

  /// 일반 문자열
  Column normalText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        if (word.sound.toString().isNotEmpty)
          Text(
            word.sound.toString(),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        Text(
          word.character,
          style: context.typo.headline6,
        ),
      ],
    );
  }

  Column patternText(BuildContext context) {
    String cleanPattern = word.pattern!.clean();

    int splitLength = word.character.split(cleanPattern).length;

    // print(cleanPattern);
    // print(word.character.split(cleanPattern));

    bool hasNoPattern = splitLength > 3 || splitLength == 1;
    String textBeforePattern = word.character.split(cleanPattern).first;
    String textAfterPattern = word.character.split(cleanPattern).last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        Text(
          word.sound.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        hasNoPattern
            ? Text(
                word.character,
                style: context.typo.headline6.copyWith(
                  color: context.color.text,
                ),
              )
            : RichText(
                text: TextSpan(
                  style: context.typo.headline6,
                  children: [
                    TextSpan(
                      text: textBeforePattern,
                      style: context.typo.headline6.copyWith(
                        color: context.color.text,
                      ),
                    ),
                    TextSpan(
                      text: cleanPattern,
                      style: context.typo.headline6.copyWith(
                        color: context.color.secondary.withOpacity(0.8),
                      ),
                    ),
                    TextSpan(
                      text: textAfterPattern,
                      style: context.typo.headline6.copyWith(
                        color: context.color.text,
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }
}
