import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/quiz/quiz_card_dynamic.dart';
import 'package:naruhodo/src/view/quiz/quiz_view_model.dart';
import 'package:naruhodo/src/widgets/empty/word_empty.dart';
import 'package:naruhodo/src/widgets/tts/mike.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/theme/component/card/line_percent.dart';
import 'package:naruhodo/util/custom/assets.dart';

class VocaQuizView extends StatefulWidget {
  const VocaQuizView({
    super.key,
    required this.viewModel,
  });
  final QuizViewModel viewModel;

  @override
  State<VocaQuizView> createState() => _VocaQuizViewState();
}

class _VocaQuizViewState extends State<VocaQuizView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
    widget.viewModel.hideSnackbarCallback =
        () => ScaffoldMessenger.of(context).hideCurrentSnackBar();

    widget.viewModel.init(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: widget.viewModel,
      builder: (context, viewModel) => (viewModel.wordList.isEmpty)
          ? WordEmpty(onRefresh: widget.viewModel.refreshData)
          : Column(
              children: [
                LinePercent(percent: viewModel.percent, size: CardSize.large),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        child: Column(
                          children: [
                            Expanded(
                              child: PageView.builder(
                                itemCount: viewModel.wordList.length,
                                controller: viewModel.pageController,
                                itemBuilder: (context, index) {
                                  return QuizCardDynamic(
                                    word: viewModel.wordList[index],
                                    size: CardSize.large,
                                    isFirst: viewModel.isFirstPage,
                                    isLast: viewModel.isLastPage,
                                    totalIndex: viewModel.totalIndex,
                                    isShowConfetti: viewModel.isShowConfetti,
                                    toggleVisible: viewModel.toggleVisibility,
                                    isPartiallyVisible:
                                        viewModel.isPartiallyVisible,
                                    isVisible: viewModel.isVisible,
                                    onPressed: viewModel.playAudio,
                                    updateAtLastPage:
                                        viewModel.updateAtLastPage,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (viewModel.isPreparing)
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          child: Lottie.asset(
                            Assets.count,
                            reverse: true,
                            repeat: true,
                            height: 300,
                          ),
                        ),
                      Positioned(
                        bottom: 10,
                        right: 0,
                        left: 0,
                        child: Mike(
                          level: viewModel.level,
                          onPressed: viewModel.toggleListen,
                          isListening: viewModel.isListening,
                        ),
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 16),
                // Text(
                //   !viewModel.speechEnabled ? "Speech not available" : "",
                //   style: const TextStyle(fontSize: 15.0),
                // ),
                // const AnkiBottomSheet(),
              ],
            ),
    );
  }
}
