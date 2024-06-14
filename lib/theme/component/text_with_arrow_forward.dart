import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class TextWithArrowForward extends StatelessWidget {
  const TextWithArrowForward({
    super.key,
    required this.title,
    this.desc,
    this.titleStyle,
    this.onArrowPressed,
    this.isExpanded,
    this.lottie,
  });
  final String title;
  final String? desc;
  final bool? isExpanded;
  final TextStyle? titleStyle;
  final Widget? lottie;
  final Function()? onArrowPressed;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onArrowPressed,
      behavior: HitTestBehavior.opaque, // 빈 공간도 감지
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: titleStyle ??
                            context.typo.headline4.copyWith(
                              fontWeight: context.typo.semiBold,
                            ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      if (lottie != null) lottie!
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (desc != null)
                    Text(
                      desc ?? "",
                      style: context.typo.body2.copyWith(
                        fontWeight: context.typo.light,
                        color: context.color.subtext,
                      ),
                    ),
                ],
              ),
            ),
            if (onArrowPressed != null)
              Icon(
                isExpanded!
                    ? Icons.arrow_circle_down
                    : Icons.arrow_circle_right_outlined,
                size: 24,
                color: context.color.text,
              ),
          ],
        ),
      ),
    );
  }
}
