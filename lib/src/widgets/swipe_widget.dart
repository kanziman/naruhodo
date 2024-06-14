import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class SwipeWidget extends StatelessWidget {
  const SwipeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 15,
      left: 0,
      right: 0,
      child: Icon(
        Icons.swipe_left,
        size: 36,
        color: context.color.tertiary,
      ),
    );
  }
}
