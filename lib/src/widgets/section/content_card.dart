import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/content.dart';
import 'package:naruhodo/src/model/section_content.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/round_container.dart';
import 'package:naruhodo/util/custom/common_consts.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';

class ContentCard extends StatelessWidget {
  final Function() onTap;
  final SectionContent content;

  const ContentCard({
    super.key,
    required this.onTap,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    // print('content $content');
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: AspectRatio(
          aspectRatio: 1,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: Custom.contentBoxDecoration(context),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: (content.title != null && content.desc != null) ? 3 : 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: _buildUpperLeftIcons(context),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (content.duration != null)
                              _buildUpperRightDuration(context),
                            if (content.random != null && content.random!)
                              _buildUpperRightRandom(context),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (content.title != null)
                  Expanded(
                    flex: 1,
                    child: Text(
                      content.title!.toString(),
                      style: context.typo.desc3.copyWith(
                        fontWeight: context.typo.semiBold,
                      ),
                    ),
                  ),
                if (content.desc != null)
                  Expanded(
                    flex: 1,
                    child: Text(
                      content.desc!.toString(),
                      style: context.typo.body2,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container _buildUpperRightRandom(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.color.tertiary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Text(
        S.current.random,
        style: context.typo.body2.copyWith(
          fontWeight: context.typo.semiBold,
          color: context.color.tertiary,
        ),
      ),
    );
  }

  Container _buildUpperRightDuration(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: context.color.secondary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(4.0),
      child: Text(
        content.duration!.toString(),
        style: context.typo.body2.copyWith(
          fontWeight: context.typo.semiBold,
          color: context.color.secondary,
        ),
      ),
    );
  }

  Column _buildUpperLeftIcons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundContainer(
          padding: 2.0,
          bgColor: context.color.primary.withOpacity(0.20),
          size: 48,
          child: Content.getIcon(content.subjectType),
        ),
      ],
    );
  }
}
