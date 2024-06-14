import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/section.dart';
import 'package:naruhodo/src/service/category_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/app_bar_main_widget.dart';
import 'package:naruhodo/src/widgets/section/content_card_container.dart';
import 'package:naruhodo/theme/component/text_with_arrow_forward.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class PatternPage extends StatefulWidget {
  const PatternPage({super.key});

  @override
  State<PatternPage> createState() => _PatternPageState();
}

class _PatternPageState extends State<PatternPage> {
  Map<int, bool> isExpandedMap = {
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
    8: false,
    9: false,
    10: false,
  };
  void toggleExpanded(int sectionIndex) {
    setState(() {
      isExpandedMap[sectionIndex] = !isExpandedMap[sectionIndex]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    SectionService sectionService = context.watch();
    List<Section> sectionData = sectionService.sectionPattern;

    return Scaffold(
      appBar: AppBarMainWidget(
        text: S.current.speak,
        showBackArrow: false,
      ),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: sectionData.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: context.color.onSurface,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: context.deco.shadowLight,
                ),
                child: Column(
                  children: [
                    TextWithArrowForward(
                      title: sectionData[index].title.toString(),
                      desc: sectionData[index].desc.toString(),
                      onArrowPressed: () => toggleExpanded(index + 1),
                      isExpanded: isExpandedMap[index + 1] ?? false,
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 555),
                      curve: Curves.easeInOut,
                      height: isExpandedMap[index + 1] ?? false
                          ? 160
                          : 0, // null을 사용하여 자동 크기 조정
                      child: SingleChildScrollView(
                        child: ContentCardContainer(
                            contents: sectionData[index].contents),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
