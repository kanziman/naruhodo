import 'package:flutter/material.dart';
import 'package:naruhodo/src/enum/anki_type.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/rectangle_container.dart';
import 'package:naruhodo/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:naruhodo/theme/res/layout.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';

class AnkiBottomSheet extends StatelessWidget {
  const AnkiBottomSheet({
    super.key,
    required this.onTap,
  });
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return BaseBottomSheet(
      isRoundAll: context.layout(false, desktop: true),
      padding: EdgeInsets.only(
        top: context.layout(16, desktop: 8),
        bottom: 8,
        left: 8,
        right: 8,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RectangleContainer(
            onTap: () => onTap(context, AnkiType.keep),
            color: context.color.secondary,
            text: S.current.keep,
            desc: S.current.keepDesc,
          ),
          RectangleContainer(
            onTap: () => onTap(context, AnkiType.hard),
            color: context.color.quaternary,
            text: S.current.hard,
            desc: S.current.hardDesc,
          ),
          RectangleContainer(
            onTap: () => onTap(context, AnkiType.good),
            color: context.color.tertiary,
            text: S.current.good,
            desc: S.current.goodDesc,
          ),
          RectangleContainer(
            onTap: () => onTap(context, AnkiType.pass),
            color: context.color.primary,
            text: S.current.pass,
            desc: S.current.passDesc,
          ),
        ],
      ),
    );
  }
}
