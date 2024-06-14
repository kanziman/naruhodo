import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/speak_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/quiz_box_text.dart';
import 'package:naruhodo/src/widgets/swipe_widget.dart';
import 'package:naruhodo/src/widgets/tab_animate.dart';
import 'package:naruhodo/src/widgets/tts/tts_button.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';
import 'package:provider/provider.dart';

class QuizCardDynamic extends StatefulWidget {
  const QuizCardDynamic({
    super.key,
    required this.word,
    CardSize? size,
    required this.isFirst,
    required this.isLast,
    required this.toggleVisible,
    required this.isVisible,
    required this.isPartiallyVisible,
    required this.isShowConfetti,
    this.updateAtLastPage,
    this.totalIndex,
    required this.onPressed,
  }) : size = size ?? CardSize.small;
  final String? totalIndex;
  final Word word;
  final CardSize size;
  final bool isFirst;
  final bool isLast;
  final VoidCallback toggleVisible;
  final bool isVisible;
  final bool isPartiallyVisible;
  final bool isShowConfetti;
  final void Function()? updateAtLastPage;
  final Function onPressed;

  @override
  State<QuizCardDynamic> createState() => _QuizCardDynamicState();
}

class _QuizCardDynamicState extends State<QuizCardDynamic>
    with SingleTickerProviderStateMixin {
  late String _wordSpoken;
  late bool _isListening;
  bool _isTapped = false;
  late final AnimationController _controller;

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

  IgnorePointer _showConfetti(BuildContext context) {
    return IgnorePointer(
      child: Lottie.asset(
        Assets.confetti,
        repeat: false,
        height: MediaQuery.sizeOf(context).height,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SpeakService speakService = context.watch();
    _wordSpoken = speakService.wordSpoken;
    _isListening = speakService.isListening;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: (BuildContext context) {
            if (!_isListening && _wordSpoken != "") {
              // print(_wordSpoken.clean());
              // print(widget.word.answer!.exInsideParentheses().clean());
              // print(widget.word.character.exInsideParentheses().clean());

              if (_wordSpoken.clean() ==
                      widget.word.answer!.exInsideParentheses().clean() ||
                  _wordSpoken.clean() ==
                      widget.word.character.exInsideParentheses().clean()) {
                speakService.isSuccessSnack(true, context);
              } else {
                speakService.isSuccessSnack(false, context);
              }
            }

            return GestureDetector(
              onTap: () {
                widget.toggleVisible();
                setState(() {
                  _isTapped = true;
                });
              },
              child: Stack(
                children: [
                  Card(
                    margin: EdgeInsets.all(widget.size.margin),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: context.color.surface,
                        boxShadow: context.deco.shadow,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: context.color.hint,
                          width: 1,
                        ),
                      ),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                const Spacer(),

                                ///=== SPOKEN
                                if (_wordSpoken != "")
                                  widget.size.getBoxText(context, _wordSpoken,
                                      widget.word.answer!),
                                const SizedBox(height: 16),

                                ///=== ANSWER
                                AnimatedOpacity(
                                    opacity: widget.isVisible ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 333),
                                    child: Text('> ${widget.word.answer!}',
                                        style: context.typo.headline3.copyWith(
                                            color: context.color.text
                                                .withOpacity(0.5)))),
                                const SizedBox(height: 16),

                                ///=== 퀴즈 예문
                                QuizBoxText(
                                  full: widget.word.character,
                                  parts: widget.word.quiz != ""
                                      ? widget.word.quiz!
                                      : widget.word.pattern!.clean(),
                                  isVisible: widget.isVisible,
                                ),
                                Divider(
                                  thickness: 0.5,
                                  color: Colors.grey.shade400,
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),

                          /// SOUND
                          // if (widget.showSound!)
                          //   widget.size
                          //       .getSubText(context, widget.word.sound.toString()),

                          // MEANING
                          Expanded(
                            flex: 1,
                            child: AnimatedOpacity(
                              opacity: widget.isPartiallyVisible ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 333),
                              child: widget.size.getText(
                                  context, widget.word.meaning.toString()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Swipe ICON,
                  if (widget.isFirst) const SwipeWidget(),

                  // Positioned TtsButton
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: TtsButton(
                      onPressed: widget.onPressed,
                      voiceUrl: widget.word.voice?['url'],
                      character: widget.word.answer!.exInsideParentheses(),
                    ),
                  ),
                  // Tab
                  if (widget.isFirst && !_isTapped)
                    TabAnimate(
                      controller: _controller,
                      bottom: 70,
                    ),
                  // Confetti
                  if (widget.isShowConfetti) _showConfetti(context),

                  /// Index
                  _showIndexOfTotal(context),
                ],
              ),
            );
          }(context),
        ),
      ],
    );
  }
}
