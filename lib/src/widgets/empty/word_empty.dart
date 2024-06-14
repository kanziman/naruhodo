import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/button/button.dart';

class WordEmpty extends StatelessWidget {
  const WordEmpty({super.key, this.onRefresh});
  final Function? onRefresh;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        color: context.color.primary,
        iconData: (Icons.refresh),
        text: "RELOAD",
        type: ButtonType.outline,
        size: ButtonSize.small,
        onPressed: () {
          onRefresh!();
        },
      ),
    );
  }
}
