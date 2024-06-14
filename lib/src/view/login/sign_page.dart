import 'package:flutter/material.dart';
import 'package:naruhodo/src/view/login/sign_in_page.dart';
import 'package:naruhodo/src/view/login/sign_up_page.dart';
import 'package:naruhodo/src/widgets/app_bar_main_widget.dart';
import 'package:naruhodo/theme/component/hide_keyboard.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => SignPageState();
}

class SignPageState extends State<SignPage> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return HideKeyboard(
      child: Scaffold(
        appBar: const AppBarMainWidget(
          text: "",
          showBackArrow: true,
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 222), // Animation duration
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: showLoginPage
              ? SigninView(key: const ValueKey('signin'), onTap: togglePages)
              : SignupView(key: const ValueKey('signup'), onTap: togglePages),
        ),
      ),
    );
  }
}
