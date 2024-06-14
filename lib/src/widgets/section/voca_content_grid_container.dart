import 'package:flutter/material.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/model/section_content.dart';
import 'package:naruhodo/src/widgets/section/content_card.dart';
import 'package:naruhodo/theme/res/layout.dart';

class VocaContentGridContainer extends StatelessWidget {
  const VocaContentGridContainer({
    super.key,
    required this.contents,
    required this.topic,
    int? crossAxisCount,
  }) : crossAxisCount = crossAxisCount ?? 3;
  final List<SectionContent> contents;
  final String topic;
  final int crossAxisCount;

  void _makeRoute(BuildContext context, SectionContent content) {
    Navigator.pushNamed(
      context,
      RoutePath.enter,
      arguments: QueryRequest(
        subjectType: content.subjectType,
        topic: topic, // N5,N4...
        from: content.from, // verbs, places...
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),

      // height: 300,
      child: GridView.count(
        primary: false,
        shrinkWrap: true,
        crossAxisCount:
            context.layout(crossAxisCount, tablet: 5, desktop: 5), //
        childAspectRatio: 1.0,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        children: List.generate(
          contents.length,
          (index) {
            SectionContent content = contents[index];
            return Padding(
              padding: const EdgeInsets.all(0.0),
              child: ContentCard(
                content: content,
                onTap: () {
                  _makeRoute(context, content);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
