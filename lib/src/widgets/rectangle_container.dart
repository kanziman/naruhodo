import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class RectangleContainer extends StatelessWidget {
  const RectangleContainer({
    super.key,
    required this.color,
    this.text,
    this.desc,
    this.child,
    required this.onTap,
  });
  final Widget? child;
  final Color? color;
  final String? text;
  final String? desc;
  // final Function()? onTap;
  // final Function(String) onTap;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 4.0),
        decoration: BoxDecoration(
          color:
              color?.withOpacity(0.1) ?? context.color.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            if (text != null)
              Text(
                text!,
                style: context.typo.headline4.copyWith(
                  fontWeight: context.typo.semiBold,
                  color: color ?? context.color.primary,
                ),
              ),
            if (desc != null)
              Text(
                desc!,
                style: context.typo.body2.copyWith(
                  fontWeight: context.typo.regular,
                  color: color ?? context.color.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
