import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/alphabet/alphabet_round.dart';
import 'package:naruhodo/src/widgets/swipe_widget.dart';
import 'package:naruhodo/src/widgets/tab_animate.dart';
import 'package:naruhodo/src/widgets/tts/tts_button.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';

class FilpCoverCard extends StatefulWidget {
  const FilpCoverCard({
    super.key,
    required this.word,
    CardSize? size,
    this.totalIndex,
    required this.isFirst,
    required this.isLast,
    required this.controller,
    this.updateAtLastPage,
    required this.onPressed,
  }) : size = size ?? CardSize.small;
  final String? totalIndex;
  final dynamic word;
  final CardSize size;
  final void Function()? updateAtLastPage;
  final bool isFirst;
  final bool isLast;
  final Function onPressed;
  final FlipCardController controller;

  @override
  State<FilpCoverCard> createState() => _FilpCoverCardState();
}

class _FilpCoverCardState extends State<FilpCoverCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isTapped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _renderContent(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Card(
          elevation: 0.0,
          margin: EdgeInsets.all(widget.size.margin),
          color: const Color(0x00000000),
          child: FlipCard(
            // flipOnTouch: false,
            controller: widget.controller,
            direction: FlipDirection.HORIZONTAL,
            side: CardSide.FRONT,
            speed: 333,
            onFlipDone: (status) {
              if (widget.updateAtLastPage != null) widget.updateAtLastPage!();
              _controller.forward();
              setState(() {
                _isTapped = true;
              });
            },
            // 앞면
            front: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  color: context.color.surface,
                  boxShadow: context.deco.shadowLight,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.color.hint, width: 1)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.size.getText(context, widget.word.character),
                ],
              ),
            ),
            // 뒷면
            back: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: context.color.surface,
                boxShadow: context.deco.shadowLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: context.color.hint, width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.word.sound.toString() != "")
                    widget.size
                        .getSubText(context, widget.word.sound.toString()),
                  if (widget.word.meaning.toString() != "")
                    widget.size
                        .getText(context, widget.word.meaning.toString()),
                ],
              ),
            ),
          ),
        ),

        /// Swipe
        if (widget.isFirst) const SwipeWidget(),

        /// ABC
        _showAlphabet(context),

        /// TTS
        _showTts(context),
        // Tab
        if (widget.isFirst && !_isTapped) TabAnimate(controller: _controller),

        /// Index
        _showIndexOfTotal(context),
      ],
    );
  }

  Positioned _showIndexOfTotal(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: Text(widget.totalIndex ?? "",
          style: context.typo.headline7.copyWith(
            color: context.color.subtext,
          )),
    );
  }

  Widget _showTts(BuildContext context) {
    // print(widget.word);
    return Positioned(
      right: 0,
      bottom: 0,
      child: TtsButton(
        onPressed: widget.onPressed,
        character: widget.word.character,
        voiceUrl: widget.word.voice?['url'],
      ),
    );
  }

  Positioned _showAlphabet(BuildContext context) {
    return Positioned(
      top: 10,
      right: 10,
      child: AlphabetRound(
        context: context,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: _renderContent(context),
        ),
      ],
    );
  }
}
