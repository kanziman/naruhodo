import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class AssetIcon extends StatelessWidget {
  const AssetIcon(
    this.icon, {
    super.key,
    this.color,
    this.size,
  });

  final String icon;
  // optional
  final Color? color;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$icon.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? context.color.text,
        BlendMode.srcIn,
      ),
    );
  }
}
