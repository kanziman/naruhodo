import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class SimpleButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  const SimpleButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: context.color.primary,
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: context.color.onHintContainer, width: 1),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: context.color.onPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 15),
          ),
        ),
      ),
    );
  }
}
