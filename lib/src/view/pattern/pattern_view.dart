import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/word.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/base/base_view.dart';
import 'package:naruhodo/src/view/pattern/pattern_row_card.dart';
import 'package:naruhodo/src/view/pattern/pattern_view_model.dart';
import 'package:naruhodo/src/widgets/empty/word_empty.dart';
import 'package:naruhodo/src/widgets/pattern_tile.dart';
import 'package:naruhodo/src/widgets/tag_card.dart';
import 'package:naruhodo/src/widgets/tag_card_tips.dart';
import 'package:naruhodo/src/widgets/tts/tts_button.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/theme/res/layout.dart';
import 'package:naruhodo/util/helper/immutable_helper.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';

class PatternView extends StatefulWidget {
  const PatternView({
    super.key,
    int? crossAxisCount,
    required this.viewModel,
  }) : crossAxisCount = crossAxisCount ?? 1;

  final int crossAxisCount;
  final PatternViewModel viewModel;

  @override
  State<PatternView> createState() => _PatternViewState();
}

class _PatternViewState extends State<PatternView> {
  @override
  void initState() {
    super.initState();
    widget.viewModel.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: widget.viewModel,
      builder: (context, viewModel) => DefaultTabController(
        length: 2,
        child: _col(context, viewModel),
      ),
    );
  }

  Column _col(BuildContext context, PatternViewModel viewModel) {
    return Column(
      children: [
        _tabBar(context),
        Expanded(
          child: (viewModel.wordList.isEmpty)
              ? WordEmpty(onRefresh: widget.viewModel.refreshData)
              : TabBarView(
                  children: [
                    /// 설명탭
                    RefreshIndicator(
                      onRefresh: widget.viewModel.refreshData,
                      color: context.color.background,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (viewModel.explanationDesc!.isNotEmpty)
                                _explanationDesc(viewModel),
                              _explanations(viewModel),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// 예문탭
                    RefreshIndicator(
                      onRefresh: widget.viewModel.refreshData,
                      color: context.color.background,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            if (viewModel.vocas.isNotEmpty)
                              SizedBox(
                                height: viewModel.vocas.length >= 6 ? 120 : 90,
                                child: GridView.builder(
                                  scrollDirection:
                                      Axis.horizontal, // 가로 스크롤 활성화
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          childAspectRatio: 0.55),
                                  itemCount: viewModel.vocas.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var word = viewModel.vocas[index];
                                    return TagCard(
                                      word: word,
                                      play: viewModel.playAudio,
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 8),
                            _patterns(context, viewModel),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }

  Expanded _patterns(BuildContext context, PatternViewModel viewModel) {
    return Expanded(
      child: SingleChildScrollView(
        child: (viewModel.wordList.isEmpty)
            ? WordEmpty(onRefresh: widget.viewModel.refreshData)
            : GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: context.layout(
                    widget.crossAxisCount,
                    tablet: 3,
                    desktop: 4,
                  ),
                  mainAxisSpacing: 2,
                  crossAxisSpacing: 8,
                  childAspectRatio: 2.5 / 1,
                ),
                itemCount: viewModel.patterns.length,
                itemBuilder: (context, index) {
                  final word = viewModel.patterns[index];
                  return PatternRowCard(
                    word: word,
                    onPressed: viewModel.playAudio,
                    isDirectionRow: false,
                  ); // 두 번째 탭 페이지
                },
              ),
      ),
    );
  }

  Widget _explanations(PatternViewModel viewModel) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: viewModel.explanations.length,
      itemBuilder: (context, index) {
        Word word = viewModel.explanations[index];
        return PatternTile(
          word: word,
          lead: TtsButton(
            height: 50,
            onPressed: viewModel.playAudio,
            size: ButtonSize.xsmall,
            character: word.answer!.exInsideParentheses(),
            voiceUrl: word.voice?['url'],
            // character: word.answer != ''
            //     ? word.answer.toString()
            //     : word.character.exInsideParentheses().replaceAll('~', ''),
          ),
        );
      },
    );
  }

  Container _explanationDesc(PatternViewModel viewModel) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Wrap(
            alignment: WrapAlignment.start,
            spacing: 4,
            children: viewModel.explanationDesc!.map((word) {
              var meaning = word.meaning.toString();
              return TagCardTips(character: 'Tips\n', meaning: meaning);
            }).toList(),
          ),
        ],
      ),
    );
  }

  TabBar _tabBar(BuildContext context) {
    return TabBar(
      // labelColor: context.color.primary,
      indicatorColor: context.color.primary,
      tabs: [
        Tab(
          child: Row(
            children: [
              Icon(
                Icons.pattern_outlined,
                color: context.color.text,
              ),
              Text(
                S.current.patterns,
                style: context.typo.body1.copyWith(
                  fontWeight: context.typo.semiBold,
                  color: context.color.text,
                ),
              ),
            ],
          ),
        ),
        Tab(
          child: Row(
            children: [
              Icon(
                Icons.book,
                color: context.color.text,
              ),
              Text(
                S.current.examples,
                style: context.typo.body1.copyWith(
                  fontWeight: context.typo.semiBold,
                  color: context.color.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
