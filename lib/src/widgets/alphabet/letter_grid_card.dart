import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class LetterGridCard extends StatefulWidget {
  const LetterGridCard({
    super.key,
    required this.word,
    double? paddingInside,
    double? sizedBoxHeightInside,
    required this.audioPlayer,
    this.onTap,
  })  : paddingInside = paddingInside ?? 16,
        sizedBoxHeightInside = sizedBoxHeightInside ?? 12;

  final Word word;

  final double paddingInside;
  final double sizedBoxHeightInside;
  final AudioPlayer audioPlayer;
  final Function(String character)? onTap;

  @override
  State<LetterGridCard> createState() => _LetterGridCardState();
}

class _LetterGridCardState extends State<LetterGridCard> {
  bool _isSpeaking = false;

  void _playAudio(url) async {
    setState(() => _isSpeaking = true);
    try {
      await widget.audioPlayer.play(UrlSource(url));
    } catch (e) {
      log('Error playing audio: $e');
    }
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _isSpeaking = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // _handleTap(widget.word.voice?['url']);
        _playAudio(widget.word.voice?['url']);
      },
      child: Container(
        padding: EdgeInsets.all(widget.paddingInside),
        decoration: BoxDecoration(
          color: context.color.surface,
          boxShadow: context.deco.shadow,
          borderRadius: BorderRadius.circular(16),
          border: _isSpeaking
              ? Border.all(
                  color: context.color.primary,
                  width: 1,
                )
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Name
            Text(
              widget.word.character,
              style: context.typo.headline1.copyWith(
                fontWeight: context.typo.semiBold,
              ),
            ),
            SizedBox(height: widget.sizedBoxHeightInside),

            /// Brand
            Text(
              widget.word.sound.toString(),
              style: context.typo.body2.copyWith(
                fontWeight: context.typo.light,
                color: context.color.subtext,
              ),
            ),
            // TtsButton(character: word.character),
          ],
        ),
      ),
    );
  }
}
