import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/util/custom/extensions.dart';

class PatternTile extends StatelessWidget {
  const PatternTile({
    super.key,
    required this.word,
    this.lead,
    double? paddingInside,
    bool? isDirectionRow,
  })  : paddingInside = paddingInside ?? 16,
        isDirectionRow = isDirectionRow ?? true;

  // final Product product;
  final Word word;
  final double paddingInside;
  final bool isDirectionRow;
  final Widget? lead;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
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
                        child: (word.pattern != null &&
                                !word.topic.contains('exp'))
                            ? patternText(context)
                            : normalText(context),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        if (lead != null)
          Positioned(
            right: 0,
            bottom: 5,
            child: lead!,
          ),
      ]),
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
    String patternTextWithoutTilde = word.pattern!.replaceAll('~', '');
    String textBeforePattern =
        word.character.split(patternTextWithoutTilde).first;
    String textAfterPattern =
        word.character.split(patternTextWithoutTilde).last;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
      children: [
        Text(
          word.sound.toString(),
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        RichText(
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
                text: patternTextWithoutTilde,
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
