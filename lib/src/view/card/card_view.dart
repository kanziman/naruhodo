import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/card/card_view_model.dart';
import 'package:naruhodo/src/view/card/flip_card_cover.dart';
import 'package:naruhodo/src/widgets/empty/word_empty.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/theme/component/card/line_percent.dart';
import 'package:naruhodo/util/custom/assets.dart';

class CardView extends StatefulWidget {
  const CardView({
    super.key,
    required this.viewModel,
  });
  final CardViewModel viewModel;

  @override
  State<CardView> createState() => _CardViewState();
}

class _CardViewState extends State<CardView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: widget.viewModel,
      builder: (context, viewModel) => (viewModel.wordList.isEmpty)
          ? WordEmpty(onRefresh: widget.viewModel.refreshData)
          : Stack(
              children: [
                Column(
                  children: [
                    LinePercent(
                        percent: viewModel.percent, size: CardSize.large),
                    Expanded(
                      child: PageView.builder(
                        itemCount: viewModel.wordList.length,
                        controller: viewModel.pageController,
                        itemBuilder: (context, index) {
                          return FilpCoverCard(
                            controller: widget.viewModel.flipController,
                            word: viewModel.wordList[index],
                            size: CardSize.xlarge,
                            totalIndex: viewModel.totalIndex,
                            isFirst: viewModel.isFirstPage,
                            isLast: viewModel.isLastPage,
                            updateAtLastPage: viewModel.updateAtLastPage,
                            onPressed: viewModel.playAudio
                          );
                        },
                      ),
                    ),
                    IgnorePointer(
                      child: Lottie.asset(
                        Assets.cat1,
                        reverse: true,
                        height: 70,
                      ),
                    ),
                  ],
                ),
                if (viewModel.isShowConfetti) _showConfetti(context),
              ],
            ),
    );
  }

  Widget _showConfetti(BuildContext context) {
    return IgnorePointer(
      child: Lottie.asset(
        Assets.confetti,
        repeat: false,
        height: MediaQuery.sizeOf(context).height,
        fit: BoxFit.contain,
      ),
    );
  }
}
