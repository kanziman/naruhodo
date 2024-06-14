import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/sentence/sentence_view_model.dart';
import 'package:naruhodo/src/widgets/row_card.dart';
import 'package:naruhodo/theme/res/layout.dart';

class VocaSentenceView extends StatefulWidget {
  const VocaSentenceView({
    super.key,
    int? crossAxisCount,
    required this.viewModel,
  }) : crossAxisCount = crossAxisCount ?? 1;

  final int crossAxisCount;
  final SentenceViewModel viewModel;

  @override
  State<VocaSentenceView> createState() => _VocaSentenceViewState();
}

class _VocaSentenceViewState extends State<VocaSentenceView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: widget.viewModel,
      builder: (context, viewModel) => Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              onRefresh: widget.viewModel.refreshData,
              color: context.color.background,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.layout(widget.crossAxisCount,
                      tablet: 3, desktop: 4), // 컬럼 수 정의
                  mainAxisSpacing: 2, // 주 축 간격
                  crossAxisSpacing: 8, // 교차 축 간격
                  childAspectRatio: 2.5 / 1, // 아이템의 너비 대 높이 비율 조정
                ),
                padding: const EdgeInsets.all(8),
                itemCount: viewModel.wordList.length,
                itemBuilder: (context, index) {
                  final word = viewModel.wordList[index];
                  return RowCard(
                    word: word,
                    isDirectionRow: false,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
