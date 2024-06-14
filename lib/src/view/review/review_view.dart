import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/review/review_view_model.dart';
import 'package:naruhodo/src/widgets/empty/word_empty.dart';
import 'package:naruhodo/src/widgets/voca_card_dynamic.dart';
import 'package:naruhodo/theme/component/bottom_sheet/anki_bottom_sheet.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/theme/component/card/line_percent.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({
    super.key,
    required this.viewModel,
  });

  final ReviewViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    log("Building PageView with initial page: ${viewModel.pageController.initialPage}");

    return BaseView(
      viewModel: viewModel,
      builder: (context, viewModel) => (viewModel.vocaList.isEmpty)
          ? WordEmpty(onRefresh: viewModel.refreshData)
          : Stack(
              children: [
                Column(
                  children: [
                    LinePercent(
                        percent: viewModel.percent, size: CardSize.large),
                    Expanded(
                      child: PageView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                        itemCount: viewModel.vocaList.length,
                        controller: viewModel.pageController,
                        itemBuilder: (context, index) {
                          return VocaCardDynamic(
                            onPressed: viewModel.playAudio,
                            isSwitchOn: viewModel.isSwitchOn,
                            toggleSwitch: viewModel.toggleSwtich,
                            toggleVisible: viewModel.toggleVisibility,
                            isPartiallyVisible: viewModel.isPartiallyVisible,
                            isVisible: viewModel.isVisible,
                            isShowConfetti: viewModel.isShowConfetti,
                            // showMeaning: true,
                            // showSound: false,
                            voca: viewModel.vocaList[index],
                            totalIndex: viewModel.totalIndex,
                            size: CardSize.large,
                            isFirst: viewModel.isFirstPage,
                            isLast: viewModel.isLastPage,
                            hideSwipe: true,
                          );
                        },
                      ),
                    ),
                    AnkiBottomSheet(
                      onTap: viewModel.saveCurrentCard,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
