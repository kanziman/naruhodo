import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/service/tts_service.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';
import 'package:provider/provider.dart';

class TtsButton extends StatefulWidget {
  final String character;
  final ButtonSize? size;
  final double? height;
  final String? voiceUrl;
  final Function onPressed;
  const TtsButton({
    super.key,
    required this.character,
    this.size,
    this.height,
    this.voiceUrl,
    required this.onPressed,
  });
  @override
  State<TtsButton> createState() => _TtsButtonState();
}

class _TtsButtonState extends State<TtsButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  bool _isSpeaking = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  void _playAudio(url) async {
    if (_isSpeaking) return;
    _onPress();
    setState(() => _isSpeaking = true);
    widget.onPressed(url);
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() => _isSpeaking = false);
    });
  }

  void _onPress() {
    var ticker = _controller.forward();
    ticker.whenComplete(() => _controller.reset());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap(String character) {
    // print(character);
    if (_isSpeaking) return;
    _onPress();

    Future.delayed(const Duration(milliseconds: 100), () {
      _isSpeaking = true;
    });
    TtsService ttsService = context.read();

    // Start speaking
    ttsService.speak(character).then((_) {
      if (mounted) {
        setState(() => _isSpeaking = false);
      }
    }).catchError((error) {
      if (mounted) {
        setState(() => _isSpeaking = false);
      }
      log('Error speaking: $error');
    });

    if (mounted) {
      setState(() => _isSpeaking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    TtsService ttsService = context.watch();
    if (!ttsService.isSpeaking) {
      _isSpeaking = false;
    }

    return Button(
      onPressed: () {
        if (widget.voiceUrl != null) {
          _playAudio(widget.voiceUrl);
        } else {
          _handleTap(widget.character.exceptions());
        }
      },
      size: widget.size ?? ButtonSize.xsmall,
      type: ButtonType.flat,
      child: Lottie.asset(
        controller: _controller,
        Assets.play,
        // repeat: false,
        height: widget.height ?? 70,
      ),
    );
    // return _button(ttsService, context);
  }

  // Button _button(TtsService ttsService, BuildContext context) {
  //   return Button(
  //     iconData: Icons.play_arrow,
  //     size: widget.size ?? ButtonSize.xsmall,
  //     type: ButtonType.flat,
  //     // color: context.color.primary,
  //     color: ttsService.isSpeaking && _isSpeaking
  //         ? context.color.primary
  //         : context.color.onHintContainer,
  //     onPressed: () {
  //       _handleTap(widget.character.exceptions());
  //     },
  //   );
  // }
}
