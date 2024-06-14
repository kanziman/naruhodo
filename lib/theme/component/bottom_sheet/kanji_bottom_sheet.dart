import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:naruhodo/src/view/card/alphatbet/alphabet_table_view.dart';
import 'package:naruhodo/src/view/card/card_view_model.dart';
import 'package:naruhodo/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:provider/provider.dart';

class KanjiBottomSheet extends StatefulWidget {
  const KanjiBottomSheet({super.key});

  @override
  State<KanjiBottomSheet> createState() => _KanjiBottomSheetState();
}

class _KanjiBottomSheetState extends State<KanjiBottomSheet> {
  late final CardViewModel cardViewModel = CardViewModel(
      learningService: context.read(), ttsService: context.read());

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.5,
        child: AlphabetTableView(
          viewModel: cardViewModel,
          crossAxisCount: 5,
        ),
      ),
    );
  }
}
