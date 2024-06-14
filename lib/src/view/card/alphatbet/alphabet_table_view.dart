import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/card/card_view_model.dart';
import 'package:naruhodo/src/widgets/alphabet/letter_grid_card.dart';
import 'package:naruhodo/theme/res/layout.dart';

class AlphabetTableView extends StatefulWidget {
  const AlphabetTableView({
    super.key,
    int? crossAxisCount,
    required this.viewModel,
  }) : crossAxisCount = crossAxisCount ?? 2;

  final CardViewModel viewModel;
  final int crossAxisCount;

  @override
  State<AlphabetTableView> createState() => _AlphabetTableViewState();
}

class _AlphabetTableViewState extends State<AlphabetTableView> {
  final AudioPlayer audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: widget.viewModel,
      builder: (context, viewModel) => RefreshIndicator(
        onRefresh: widget.viewModel.refreshData,
        color: context.color.background,
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: context.layout(widget.crossAxisCount,
                tablet: 5, desktop: 5), // 컬럼 수 정의
            mainAxisSpacing: 16, // 주 축 간격
            crossAxisSpacing: 8, // 교차 축 간격
            childAspectRatio: 1 / 1.1, // 아이템의 너비 대 높이 비율 조정
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          itemCount: viewModel.wordList.length,
          itemBuilder: (context, index) {
            final word = viewModel.wordList[index];
            return LetterGridCard(
              word: word,
              paddingInside: 4,
              sizedBoxHeightInside: 4,
              audioPlayer: audioPlayer,
            );
          },
        ),
      ),
    );
  }
}
