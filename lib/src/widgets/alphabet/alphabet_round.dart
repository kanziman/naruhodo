import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/subject_type.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/service/learning_service.dart';
import 'package:naruhodo/src/widgets/round_container.dart';
import 'package:naruhodo/theme/component/bottom_sheet/kanji_bottom_sheet.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:provider/provider.dart';

class AlphabetRound extends StatelessWidget {
  const AlphabetRound({
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
          RoundContainer(
            bgColor: context.color.hint,
            size: 36,
            child: Button(
              text: 'あ',
              size: ButtonSize.small,
              type: ButtonType.flat,
              color: context.color.onHintContainer,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    changeQueryRequest(SubjectType.hiraganaTable, 'hiragana');
                    return const KanjiBottomSheet();
                  },
                );
              },
            ),
          ),
          const SizedBox(width: 8),
          RoundContainer(
            bgColor: context.color.hint,
            size: 36,
            child: Button(
              text: 'ア',
              size: ButtonSize.small,
              type: ButtonType.flat,
              color: context.color.onHintContainer,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) {
                    changeQueryRequest(SubjectType.katakanaTable, 'katakana');
                    return const KanjiBottomSheet();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
