import 'package:flutter/material.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/card/voca/voca_view_model.dart';
import 'package:naruhodo/src/widgets/empty/word_empty.dart';
import 'package:naruhodo/src/widgets/voca_card_dynamic.dart';
import 'package:naruhodo/theme/component/bottom_sheet/anki_bottom_sheet.dart';
import 'package:naruhodo/theme/component/card/card_size.dart';
import 'package:naruhodo/theme/component/card/line_percent.dart';

class VocaView extends StatefulWidget {
  const VocaView({
    super.key,
    required this.viewModel,
  });
  final VocaViewModel viewModel;

  @override
  State<VocaView> createState() => _VocaViewState();
}

class _VocaViewState extends State<VocaView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: widget.viewModel,
      builder: (context, viewModel) => (viewModel.vocaList.isEmpty)
          ? WordEmpty(onRefresh: widget.viewModel.refreshData)
          : Stack(
              children: [
                Column(
                  children: [
                    LinePercent(
                        percent: viewModel.percent, size: CardSize.large),
                    Expanded(
                      child: PageView.builder(
                        itemCount: viewModel.vocaList.length,
                        controller: viewModel.pageController,
                        itemBuilder: (context, index) {
                          return VocaCardDynamic(
                              isSwitchOn: viewModel.isSwitchOn,
                              toggleSwitch: viewModel.toggleSwtich,
                              toggleVisible: viewModel.toggleVisibility,
                              isPartiallyVisible: viewModel.isPartiallyVisible,
                              isVisible: viewModel.isVisible,
                              voca: viewModel.vocaList[index],
                              totalIndex: viewModel.totalIndex,
                              size: CardSize.large,
                              isFirst: viewModel.isFirstPage,
                              isLast: viewModel.isLastPage,
                              onPressed: viewModel.playAudio,
                              isShowConfetti: viewModel.isShowConfetti);
                        },
                      ),
                    ),

                    AnkiBottomSheet(
                      onTap: viewModel.saveCurrentCard,
                    ),

                    // const SizedBox(height: 32),
                    // const AnkiBottomSheet(),
                  ],
                ),
              ],
            ),
    );
  }
}
