import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/model/voca.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/quiz_box.dart';
import 'package:naruhodo/src/widgets/swipe_widget.dart';
import 'package:naruhodo/src/widgets/tab_animate.dart';
import 'package:naruhodo/src/widgets/tts/tts_button.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';

class VocaCardDynamic extends StatefulWidget {
  const VocaCardDynamic({
    super.key,
    required this.voca,
    CardSize? size,
    required this.isFirst,
    required this.isLast,
    this.totalIndex,
    required this.isVisible,
    required this.isPartiallyVisible,
    required this.toggleVisible,
    required this.isSwitchOn,
    required this.toggleSwitch,
    this.hideSwipe,
    this.isShowConfetti,
    required this.onPressed,
  }) : size = size ?? CardSize.small;

  final Voca voca;
  final CardSize size;
  final String? totalIndex;
  final bool isFirst;
  final bool isLast;
  final bool? isShowConfetti;
  //QuizBox
  final bool isVisible;
  final bool isPartiallyVisible;
  final bool isSwitchOn;
  final VoidCallback toggleVisible;
  final VoidCallback toggleSwitch;
  final Function onPressed;

  final bool? hideSwipe;
  @override
  State<VocaCardDynamic> createState() => _VocaCardDynamicState();
}

class _VocaCardDynamicState extends State<VocaCardDynamic>
    with SingleTickerProviderStateMixin {
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

  _renderContent(BuildContext context) {
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
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /// 단어 tts
                        const Spacer(),
                        _showTtsSmall(),

                        /// 단어!
                        widget.isSwitchOn
                            ? widget.size
                                .getTitleText(context, widget.voca.voca)
                            : widget.size.getTitleText(context,
                                widget.voca.voca.exInsideParentheses()),
                        // const SizedBox(height: 16),

                        /// 단어뜻!
                        AnimatedOpacity(
                          opacity: widget.isVisible ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 333),
                          child: widget.size.getTitleText(
                              context, widget.voca.vocaMean.toString()),
                        ),
                      ],
                    ),
                  ),

                  /// 예문
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        widget.isSwitchOn
                            ? widget.size.getColorText(
                                context,
                                widget.voca.voca.exInsideParentheses(),
                                widget.voca.expression)
                            : widget.size.getColorText(
                                context,
                                widget.voca.voca.exInsideParentheses(),
                                widget.voca.expression.exInsideParentheses()),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  Divider(thickness: 0.5, color: Colors.grey.shade400),

                  /// 예문뜻
                  Expanded(
                    flex: 1,
                    child: QuizBox(
                      full: widget.voca.meaning.toString(),
                      parts: widget.voca.quiz.toString(),
                      isPartiallyVisible: widget.isPartiallyVisible,
                      isVisible: widget.isVisible,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // page index
          _showIndexOfTotal(context),
          // Switch
          _showSwitchIcon(context),

          // Tts
          _showTts(),
          // Tab
          if (widget.isFirst) const SwipeWidget(),
          // Tab
          if (widget.isFirst && !_isTapped) TabAnimate(controller: _controller),

          // Confettie
          if (widget.isShowConfetti!) _showConfetti(context),
        ],
      ),
    );
  }

  Widget _showTtsSmall() {
    return TtsButton(
      height: 50,
      onPressed: widget.onPressed,
      voiceUrl: widget.voca.voice?['vocaUrl'],
      character: widget.voca.voca.exInsideParentheses(),
    );
  }

  Widget _showTts() {
    return Positioned(
      right: 0,
      bottom: 0,
      child: TtsButton(
        onPressed: widget.onPressed,
        voiceUrl: widget.voca.voice?['expUrl'],
        character: widget.voca.expression.exInsideParentheses(),
      ),
    );
  }

  Positioned _showIndexOfTotal(BuildContext context) {
    return Positioned(
      top: 20,
      left: 20,
      child: widget.size.getSubText(context, widget.totalIndex ?? ""),
    );
  }

  Positioned _showSwitchIcon(BuildContext context) {
    return Positioned(
      top: 8,
      right: 8,
      child: Switch(
        value: widget.isSwitchOn,
        onChanged: (bool value) {
          widget.toggleSwitch();
        },
        activeColor: context.color.primary, // 스위치가 켜진 경우의 색상
        inactiveThumbColor: context.color.hint, // 스위치가 꺼진 경우의 색상
        inactiveTrackColor: context.color.inactive, // 트랙의 색상
      ),
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
