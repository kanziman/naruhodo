import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class Mike extends StatelessWidget {
  const Mike({
    super.key,
    required this.level,
    required this.onPressed,
    required this.isListening,
  });

  final double level;
  final bool isListening;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    log('islistening $isListening');
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: .26,
                spreadRadius: !isListening ? 30 : level * 1.5,
                color: isListening
                    ? context.color.text.withOpacity(.25)
                    : context.color.text.withOpacity(.05))
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30)),
        ),
        child: IconButton(
          icon: isListening ? const Icon(Icons.mic) : const Icon(Icons.mic_off_outlined),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
