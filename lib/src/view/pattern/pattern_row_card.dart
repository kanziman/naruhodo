import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/tts/tts_button.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';

class PatternRowCard extends StatelessWidget {
  const PatternRowCard({
    super.key,
    required this.word,
    double? paddingInside,
    bool? isDirectionRow,
    required this.onPressed,
  }) : paddingInside = paddingInside ?? 16;

  // final Product product;
  final Word word;
  final double paddingInside;
  final Function onPressed;

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
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: paddingInside,
              vertical: paddingInside,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  cardColumn(context),
                ],
              ),
            ),
          ),
          Positioned(
            right: 5,
            bottom: 5,
            child: TtsButton(
              onPressed: onPressed,
              height: 50,
              size: ButtonSize.xsmall,
              character: word.answer!.exInsideParentheses(),
              voiceUrl: word.voice?['url'],
            ),
          ),
        ],
      ),
    );
  }

  /// 세로
  Widget cardColumn(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬을 위해
          children: [
            /// 해석
            Text(
              word.meaning.toString(),
              style: context.typo.body1,
            ),
            const SizedBox(height: 4),
            Divider(
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 4),

            /// 패턴문장
            (word.pattern != null) ? patternText(context) : normalText(context),
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
          style: context.typo.body2,
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
        hasNoPattern
            ? Text(
                word.character,
                style: context.typo.headline7.copyWith(
                  color: context.color.text,
                ),
              )
            : RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: textBeforePattern,
                      style: context.typo.headline7.copyWith(
                        color: context.color.text,
                      ),
                    ),
                    TextSpan(
                      text: cleanPattern,
                      style: context.typo.headline7.copyWith(
                        color: context.color.secondary.withOpacity(0.8),
                      ),
                    ),
                    TextSpan(
                      text: textAfterPattern,
                      style: context.typo.headline7.copyWith(
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
