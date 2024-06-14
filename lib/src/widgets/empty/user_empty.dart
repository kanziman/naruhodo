import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/button/button.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';

class UserEmpty extends StatelessWidget {
  const UserEmpty({super.key, this.onPress});
  final Function? onPress;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            Assets.cat2,
            repeat: true,
            height: 100,
          ),
          const SizedBox(height: 50),
          Button(
            color: context.color.text,
            text: S.current.login,
            icon: 'arrow-left',
            type: ButtonType.flat,
            borderColor: context.color.text,
            size: ButtonSize.xlarge,
            onPressed: () => onPress!(),
          ),
        ],
      ),
    );
  }
}
