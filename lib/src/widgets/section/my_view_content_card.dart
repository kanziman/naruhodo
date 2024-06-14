import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/asset_icon.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MyViewContentCard extends StatelessWidget {
  final Function() onTap;
  final Function(String) onResetPressed;
  final TextStyle? style;
  final double percent;
  final int totalCards;
  final int reviewedCards;
  final String topic;

  const MyViewContentCard({
    super.key,
    required this.onResetPressed,
    required this.onTap,
    this.style,
    required this.percent,
    required this.totalCards,
    required this.reviewedCards,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 36),
            decoration: BoxDecoration(
              color: context.color.surface,
              borderRadius: BorderRadius.circular(10),
              boxShadow: context.deco.shadowLight,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // CIRCULARE 퍼센트 2개
                      Row(
                        children: [
                          Text(
                            S.current.learningCheer,
                            style: context.typo.headline8.copyWith(
                              fontWeight: context.typo.regular,
                            ),
                          ),
                        ],
                      ),

                      // CIRCULARE 퍼센트 2개
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            flex: 2, // 비율 2
                            child: _circularPercentIndicatorWrapper(
                                context,
                                "${(percent * 100).toInt()}%",
                                context.color.senary),
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            flex: 2, // 비율 2
                            child: _circularPercentIndicatorWrapper(
                                context,
                                '$reviewedCards/$totalCards',
                                context.color.septenary),
                          ),
                          // const SizedBox(width: 8),
                          Expanded(
                            flex: 2, // 비율 1
                            child: Lottie.asset(
                              Assets.book,
                              repeat: true,
                              height: 64,
                            ),
                          ),
                        ],
                      ),

                      // CONTINUE 누르면 이동
                      GestureDetector(
                        onTap: onTap,
                        behavior: HitTestBehavior.translucent,
                        child: Row(
                          children: [
                            Text(
                              S.current.continueMessage,
                              style: context.typo.desc1.copyWith(
                                color: context.color.primary,
                              ),
                            ),
                            AssetIcon(
                              'chevron-right',
                              color: context.color.primary,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        /// 토픽 N5, N4, N3...
        Positioned(
          top: 0,
          left: 0,
          child: Button(
            onPressed: () {},
            color: context.color.quaternary,
            text: topic,
            size: ButtonSize.medium,
            type: ButtonType.flat,
          ),
        ),

        /// 토픽 리뷰 RESET...
        Positioned(
          top: 0,
          right: 0,
          child: Button(
            onPressed: () {
              onResetPressed(topic);
            },
            color: context.color.hint,
            iconData: Icons.delete,
            size: ButtonSize.medium,
            type: ButtonType.flat,
          ),
        ),
      ],
    );
  }

  CircularPercentIndicator _circularPercentIndicatorWrapper(
      BuildContext context, String text, Color color) {
    return CircularPercentIndicator(
      animation: true,
      animationDuration: 1000,
      radius: 36.0,
      lineWidth: 10.0,
      percent: percent,
      center: Text(
        text,
        style: context.typo.body2.copyWith(color: color),
      ),
      progressColor: color,
      backgroundColor: color.withOpacity(0.2),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
