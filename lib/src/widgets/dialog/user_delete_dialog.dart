import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/base_dialog.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';

class UserDelelteDialog extends StatelessWidget {
  const UserDelelteDialog({
    super.key,
    required this.onDeletePressed,
  });

  final void Function() onDeletePressed;

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: S.current.delete,
      content: Text(
        S.current.deleteDialogDesc,
        style: context.typo.headline6,
      ),
      actions: [
        /// Delete
        Button(
          text: S.current.delete,
          width: double.infinity,
          color: context.color.onSecondary,
          backgroundColor: context.color.secondary,
          onPressed: () {
            Navigator.pop(context);
            onDeletePressed();
          },
        ),
        const SizedBox(height: 12),

        /// Cancel
        Button(
          text: S.current.cancel,
          width: double.infinity,
          color: context.color.text,
          borderColor: context.color.background,
          type: ButtonType.outline,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
