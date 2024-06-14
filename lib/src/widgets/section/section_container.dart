import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/text_with_arrow_forward.dart';

class SectionContainer extends StatelessWidget {
  final String title; // The title to display in the TextWithArrowForward
  final String desc; // The description to display in the TextWithArrowForward
  final Widget
      child; // The child widget to display below the TextWithArrowForward
  final LottieBuilder? lottie;

  const SectionContainer({
    super.key,
    required this.title,
    required this.desc,
    required this.child,
    this.lottie,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          TextWithArrowForward(
            title: title,
            desc: desc,
            lottie: lottie,
            titleStyle: context.typo.headline4.copyWith(
              fontWeight: context.typo.semiBold,
            ),
          ),
          child, // Place the passed child widget here
        ],
      ),
    );
  }
}
