import 'package:flutter/material.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/model/section_content.dart';
import 'package:naruhodo/src/widgets/section/content_card.dart';

class ContentCardContainer extends StatelessWidget {
  const ContentCardContainer({
    super.key,
    required this.contents,
  });
  final List<SectionContent> contents;

  void _makeRoute(BuildContext context, SectionContent content) {
    Navigator.pushNamed(
      context,
      RoutePath.enter,
      arguments: QueryRequest(
          subjectType: content.subjectType,
          from: content.from,
          topic: content.title?.en),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 160,
      child: ListView.builder(
        // primary: false,
        // shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: contents.length,
        itemBuilder: (BuildContext context, int index) {
          SectionContent content = contents[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ContentCard(
              content: content,
              onTap: () {
                _makeRoute(context, content);
              },
            ),
          );
        },
      ),
    );
  }
}
