import 'package:flutter/material.dart';
import 'package:naruhodo/util/custom/extensions.dart';

class RoundContainer extends StatelessWidget {
  final double size;
  final double? padding;
  final Color bgColor;
  final Widget child;
  const RoundContainer({
    super.key,
    required this.size,
    required this.bgColor,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding ?? .2.w),
      // height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
      ),
      child: child,
    );
  }
}
