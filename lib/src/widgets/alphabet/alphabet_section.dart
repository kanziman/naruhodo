import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/alphabet/category_card.dart';
import 'package:naruhodo/theme/component/bottom_sheet/kanji_bottom_sheet.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class AlphabetSection extends StatelessWidget {
  const AlphabetSection({
    super.key,
    required this.context,
  });

  final BuildContext context;

  void changeQueryRequest(SubjectType typeTable, String topic) {
    context.read<LearningService>().setQueryRequest(
          QueryRequest(
            topic: topic,
            subjectType: typeTable,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// 히라가나
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  changeQueryRequest(SubjectType.hiraganaTable, 'hiragana');
                  return const KanjiBottomSheet();
                },
              );
            },
            child: CategoryCard(
              title: S.current.hiragana,
              child: Text(
                'あ',
                style: context.typo.headline1.copyWith(
                  fontWeight: context.typo.semiBold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  changeQueryRequest(SubjectType.katakanaTable, 'katakana');
                  return const KanjiBottomSheet();
                },
              );
            },
            child: CategoryCard(
              title: S.current.katakana,
              child: Text(
                'ア',
                style: context.typo.headline1.copyWith(
                  fontWeight: context.typo.semiBold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
