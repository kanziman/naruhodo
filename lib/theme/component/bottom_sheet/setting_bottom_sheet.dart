import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/src/service/lang_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/login/sign_page.dart';
import 'package:naruhodo/theme/component/bottom_sheet/base_bottom_sheet.dart';
import 'package:naruhodo/theme/component/tile.dart';
import 'package:naruhodo/util/helper/intl_helper.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class SettingBottomSheet extends StatelessWidget {
  const SettingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isLightTheme = context.theme.brightness == Brightness.light;
    // final LangService langService = context.watch();
    final AuthService authService = context.watch();
    User? user = authService.currentUser();

    return BaseBottomSheet(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Theme Tile
          Tile(
            icon: isLightTheme ? 'sunny' : 'moon',
            title: S.current.theme,
            desc: isLightTheme ? S.current.light : S.current.dark,
            onPressed: context.read<ThemeService>().toggleTheme,
          ),
          Tile(
              icon: 'language',
              title: S.current.language,
              desc: IntlHelper.isKo ? S.current.ko : S.current.en,
              onPressed: context.langService.toggleLang),
          Tile(
            iconData: Icons.login,
            title: user == null ? S.current.login : S.current.logOut,
            desc: user == null ? S.current.join : "",
            onPressed: () {
              user == null
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignPage(),
                      ),
                    )
                  : authService.signOut();
            },
          ),
          // if (authService.userData?['isAdmin'] != null &&
          //     authService.userData?['isAdmin'])
          //   Tile(
          //     icon: 'check',
          //     title: 'Admin',
          //     desc: "",
          //     onPressed: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => const AdminView(),
          //         ),
          //       );
          //     },
          //   ),
        ],
      ),
    );
  }
}
