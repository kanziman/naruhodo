import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class CategoryCard extends StatelessWidget {
  final String? title;
  final Widget? child;
  final IconData? icon;
  final double? size;
  const CategoryCard({
    super.key,
    this.title,
    this.icon,
    this.child,
    double? size,
  }) : size = size ?? 70;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            color: context.color.surface,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: context.deco.shadowLight,
          ),
          child: Center(child: child),
        ),
        if (title != null)
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Text(
              title!,
              style: context.typo.body2.copyWith(color: context.color.subtext),
            ),
          )
      ],
    );
  }
}
