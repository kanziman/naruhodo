import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/widgets/round_container.dart';
import 'package:naruhodo/theme/component/bottom_sheet/setting_bottom_sheet.dart';
import 'package:naruhodo/theme/component/button/button.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundContainer(
          bgColor: Colors.white.withOpacity(0.30),
          size: 48,
          child: Button(
            color: context.color.primary,
            icon: 'option',
            type: ButtonType.flat,
            size: ButtonSize.small,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) {
                  return const SettingBottomSheet();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
