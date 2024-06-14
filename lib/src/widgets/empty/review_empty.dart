import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';

class ReviewEmpty extends StatelessWidget {
  const ReviewEmpty({super.key, this.onPress});
  final Function? onPress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Button(
        color: context.color.text,
        text: S.current.noReview,
        type: ButtonType.flat,
        size: ButtonSize.large,
        onPressed: () => {},
      ),
    );
  }
}
