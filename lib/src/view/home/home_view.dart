import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/section.dart';
import 'package:naruhodo/src/service/category_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/alphabet/alphabet_section.dart';
import 'package:naruhodo/src/widgets/app_bar_main_widget.dart';
import 'package:naruhodo/src/widgets/section/content_card_container.dart';
import 'package:naruhodo/src/widgets/section/section_container.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    SectionService sectionService = context.watch();
    List<Section> sectionData = sectionService.sectionHome;

    return Scaffold(
      appBar: AppBarMainWidget(
        text: S.current.app,
        showBackArrow: false,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              /// 히라가나, 가타카나
              SectionContainer(
                title: 'ABC',
                desc: S.current.alphabetDesc,
                child: AlphabetSection(context: context),
              ),

              /// 섹션
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sectionData.length,
                itemBuilder: (context, index) {
                  Section data = sectionData[index];

                  return SectionContainer(
                    title: data.title.toString(),
                    desc: data.desc.toString(),
                    child: ContentCardContainer(contents: data.contents),
                  );
                },
              ),

              /// 하단 문구
              _bottomText(context),
            ],
          ),
        ),
      ),
    );
  }

  Padding _bottomText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: context.color.tertiary,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  S.current.great,
                  style: context.typo.headline5.copyWith(
                    color: context.color.onTertiary,
                    fontWeight: context.typo.semiBold,
                  ),
                ),
                Text(
                  S.current.greatDesc,
                  style: context.typo.body2
                      .copyWith(color: context.color.onTertiary),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
