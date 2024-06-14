import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class LinePercent extends StatelessWidget {
  const LinePercent({
    super.key,
    required this.percent,
    CardSize? size,
  }) : size = size ?? CardSize.small;

  final double percent;
  final CardSize size;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: size.margin,
        right: size.margin,
        top: size.margin,
        bottom: size.margin,
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: context.color.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: context.deco.shadowLight,
        ),
        child: Column(
          children: [
            Container(
              alignment: FractionalOffset(percent, 1 - percent),
              child: FractionallySizedBox(
                child: Icon(
                  Icons.directions_bike,
                  color: context.color.primary,
                ),
              ),
            ),
            const SizedBox(height: 6),
            LinearPercentIndicator(
              // width: MediaQuery.of(context).size.width,
              lineHeight: 6,
              barRadius: const Radius.circular(8),
              animation: false,
              percent: percent,
              backgroundColor: context.color.hint,
              progressColor: context.color.primary,
            ),
            Text(
              '${(percent * 100).toStringAsFixed(0)}%', // 진행 퍼센트 표시
              style: context.typo.headline6.copyWith(
                color: context.color.onHintContainer,
              ),
            ),
            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
