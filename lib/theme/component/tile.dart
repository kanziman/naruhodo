import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/asset_icon.dart';

class Tile extends StatelessWidget {
  const Tile({
    super.key,
    this.icon,
    this.iconData,
    this.title,
    this.desc,
    required this.onPressed,
  });

  final String? icon;
  final IconData? iconData;
  final String? title;
  final String? desc;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (icon != null) AssetIcon(icon!),
            if (iconData != null)
              Icon(
                iconData,
                color: context.color.text,
              ),
            const SizedBox(width: 8),
            if (title != null)
              Expanded(
                child: Text(
                  title!,
                  style: context.typo.headline5,
                ),
              ),
            const SizedBox(width: 8),
            if (desc != null)
              Text(
                desc!,
                style: context.typo.desc1.copyWith(
                  color: context.color.primary,
                ),
              ),
            const SizedBox(width: 8),
            const AssetIcon('chevron-right')
          ],
        ),
      ),
    );
  }
}
