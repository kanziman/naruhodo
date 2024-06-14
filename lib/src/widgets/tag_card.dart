import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class TagCard extends StatefulWidget {
  const TagCard({
    super.key,
    required this.word,
    required this.play,
  });

  final Word word;
  final Function play;

  @override
  State<TagCard> createState() => _TagCardState();
}

class _TagCardState extends State<TagCard> {
  bool _isSpeaking = false;
  @override
  Widget build(BuildContext context) {
    void playAudio(url) {
      setState(() => _isSpeaking = true);
      widget.play(url);
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() => _isSpeaking = false);
      });
    }

    return GestureDetector(
      onTap: () {
        playAudio(widget.word.voice?['url']);
        // _handleTap(widget.character!.exInsideParentheses());
      },
      child: Container(
        height: 50,
        margin: const EdgeInsets.all(2),
        padding: EdgeInsets.all(_isSpeaking ? 2 : 4),
        decoration: BoxDecoration(
          color: context.color.quinary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: _isSpeaking
              ? Border.all(
                  color: context.color.quinary,
                  width: 2,
                )
              : null,
        ),
        child: Text(
          '${widget.word.character}\n${widget.word.meaning.toString()}',
          style: context.typo.body2.copyWith(
            fontWeight: context.typo.semiBold,
            color: context.color.quinary,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}
