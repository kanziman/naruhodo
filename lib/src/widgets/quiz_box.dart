import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';

class QuizBox extends StatelessWidget {
  final String full;
  final String parts;
  final bool isVisible;
  final bool isPartiallyVisible;

  const QuizBox({
    super.key,
    required this.full,
    required this.parts,
    required this.isVisible,
    required this.isPartiallyVisible,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedOpacity(
          opacity: isPartiallyVisible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 444),
          child: RichText(
            text: TextSpan(
              children: _buildTextSpans(context),
              style: DefaultTextStyle.of(context).style,
            ),
          ),
        ),
      ),
    );
  }

  List<InlineSpan> _buildTextSpans(BuildContext context) {
    List<InlineSpan> spans = [];
    int start = 0;
    List<String> partList = parts.split(',');

    while (start < full.length) {
      int nextStart = full.length;

      for (String part in partList) {
        part = part.replaceParenthesesExt();
        final startIndex = full.indexOf(part, start);

        if (startIndex != -1 && startIndex < nextStart) {
          if (startIndex > start) {
            String precedingText = full.substring(start, startIndex);
            spans.add(
              TextSpan(
                text: precedingText,
                style: precedingText.trim().isEmpty
                    ? _getTextStyle(context)
                        .copyWith(decoration: TextDecoration.none)
                    : _getTextStyle(context),
              ),
            );
          }

          spans.add(
            TextSpan(
              text: full.substring(startIndex, startIndex + part.length),
              style: _getPartialVisibilityStyle(context, part),
            ),
          );
          nextStart = startIndex + part.length;
        }
      }

      if (nextStart == full.length) {
        String remainingText = full.substring(start);
        spans.add(
          TextSpan(
            text: remainingText,
            style: remainingText.trim().isEmpty
                ? _getTextStyle(context)
                    .copyWith(decoration: TextDecoration.none)
                : _getTextStyle(context),
          ),
        );
        break;
      }

      start = nextStart;
    }

    return spans;
  }

  TextStyle _getTextStyle(BuildContext context) {
    if (isVisible || isPartiallyVisible) {
      return context.typo.headline5.copyWith(color: context.color.subtext);
    } else {
      return const TextStyle(color: Colors.transparent);
    }
  }

  TextStyle _getPartialVisibilityStyle(BuildContext context, String part) {
    if (isVisible) {
      return context.typo.quizStyle.copyWith(
        // backgroundColor: context.color.hint,
        color: context.color.quaternary,
        // decoration: TextDecoration.underline,
        decorationColor: context.color.text,
        decorationThickness: 0.5,
      );
    } else if (isPartiallyVisible) {
      return context.typo.quizStyle.copyWith(
        color: Colors.transparent,
        decoration: TextDecoration.underline,
        decorationColor: context.color.text,
        decorationThickness: 0.5,
      );
    } else {
      return const TextStyle(color: Colors.transparent);
    }
  }
}
