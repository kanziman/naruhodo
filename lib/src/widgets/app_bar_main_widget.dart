import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/theme/component/appbar/app_bar_button.dart';
import 'package:naruhodo/theme/component/pop_button.dart';

class AppBarMainWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? action;
  final Function()? onBackButtonPressed;
  final bool? showBackArrow;
  const AppBarMainWidget(
      {super.key,
      required this.text,
      this.action,
      this.onBackButtonPressed,
      this.showBackArrow = true});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      // foregroundColor: Colors.transparent,
      elevation: 0.0,
      title: Text(
        text,
        style: context.typo.headline5.copyWith(
          fontWeight: context.typo.semiBold,
          color: context.color.primary,
        ),
      ),
      leading: showBackArrow == true ? const PopButton() : null,
      actions: const [AppBarButton()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      /*MyTheme.lightTheme.appBarTheme.toolbarHeight ??*/ kToolbarHeight);
}
