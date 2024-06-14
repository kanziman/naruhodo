import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/card/card_view_model.dart';
import 'package:naruhodo/src/view/card/flip_card_cover.dart';
import 'package:naruhodo/src/widgets/empty/word_empty.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/theme/component/card/line_percent.dart';
import 'package:naruhodo/util/custom/assets.dart';

class AlphabetCardView extends StatefulWidget {
  const AlphabetCardView({
    super.key,
    required this.viewModel,
    this.cardSize,
  });
  final CardViewModel viewModel;
  final CardSize? cardSize;
  @override
  State<AlphabetCardView> createState() => _AlphabetCardViewState();
}

class _AlphabetCardViewState extends State<AlphabetCardView> {
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
                      child: RefreshIndicator(
                        onRefresh: widget.viewModel.refreshData,
                        color: context.color.background,
                        child: PageView.builder(
                          itemCount: viewModel.wordList.length,
                          controller: viewModel.pageController,
                          itemBuilder: (context, index) {
                            return FilpCoverCard(
                              onPressed: viewModel.playAudio,
                              controller: widget.viewModel.flipController,
                              updateAtLastPage: viewModel.updateAtLastPage,
                              word: viewModel.wordList[index],
                              size: widget.cardSize,
                              totalIndex: viewModel.totalIndex,
                              isFirst: viewModel.isFirstPage,
                              isLast: viewModel.isLastPage,
                            );
                          },
                        ),
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

  IgnorePointer _showConfetti(BuildContext context) {
    return IgnorePointer(
      child: Lottie.asset(
        Assets.confetti,
        repeat: false,
        height: MediaQuery.sizeOf(context).height,
      ),
    );
  }
}
