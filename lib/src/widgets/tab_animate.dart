import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/util/custom/assets.dart';

class TabAnimate extends StatelessWidget {
  const TabAnimate({
    super.key,
    required AnimationController controller,
    this.bottom,
  }) : _controller = controller;

  final double? bottom;
  final AnimationController _controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: bottom ?? 15,
      child: IgnorePointer(
        child: Lottie.asset(
          controller: _controller,
          Assets.touch,
          repeat: true,
          height: 70,
        ),
      ),
    );
  }
}
