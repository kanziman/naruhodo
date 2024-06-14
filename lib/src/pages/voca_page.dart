import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/section_content.dart';
import 'package:naruhodo/src/service/category_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/app_bar_main_widget.dart';
import 'package:naruhodo/src/widgets/section/voca_content_grid_container.dart';
import 'package:naruhodo/theme/component/text_with_arrow_forward.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class VocaPage extends StatefulWidget {
  const VocaPage({super.key});

  @override
  State<VocaPage> createState() => _VocaPageState();
}

class _VocaPageState extends State<VocaPage> {
  Map<int, bool> isExpandedMap = {
    0: false, // n5
    1: false, // n4
    2: false, // n3
  };
  void toggleExpanded(int sectionIndex) {
    setState(() {
      isExpandedMap[sectionIndex] = !isExpandedMap[sectionIndex]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    SectionService sectionService = context.watch();
    Map<String, List<SectionContent>> sectionVoca = sectionService.sectionVoca;
    // print('sectionVoca ${sectionVoca}');
    return Scaffold(
      appBar: AppBarMainWidget(
        text: S.current.voca,
        showBackArrow: false,
      ),

      //_appBar(),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: sectionVoca.length,
          itemBuilder: (context, index) {
            // 'N5', 'N4', etc.
            var levelKey = sectionVoca.keys.toList()[index];
            var vocabItems = sectionVoca[levelKey];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: context.color.onSurface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: context.deco.shadowLight,
                ),
                child: buildSection(
                  levelKey,
                  [
                    VocaContentGridContainer(
                        contents: vocabItems!, topic: levelKey)
                  ],
                  index,
                  isExpandedMap[index] ?? false,
                  toggleExpanded,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildSection(String title, List<Widget> contents, int sectionIndex,
      bool isExpanded, void Function(int) onArrowPressed) {
    return Column(
      children: [
        TextWithArrowForward(
          title: title,
          onArrowPressed: () => onArrowPressed(sectionIndex),
          isExpanded: isExpanded,
        ),
        ClipRect(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: isExpanded ? MediaQuery.sizeOf(context).height * 0.55 : 0,
            child: SingleChildScrollView(
              child: Column(
                children: contents,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
