import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/view/login/sign_page.dart';
import 'package:naruhodo/src/pages/home_page.dart';
import 'package:naruhodo/src/widgets/simple/simple_button.dart';
import 'package:naruhodo/src/widgets/simple/simple_textfield.dart';
import 'package:naruhodo/theme/component/toast/toast.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class SigninView extends StatefulWidget {
  final Function()? onTap;
  const SigninView({super.key, required this.onTap});

  @override
  State<SigninView> createState() => _SigninViewState();
}

class _SigninViewState extends State<SigninView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> onSignOut() async {
    final AuthService authService = context.read();
    await authService.signOut();

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SignPage()),
    );
  }

  void onSignIn() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: CircularProgressIndicator(
            color: context.color.background,
          ),
        );
      },
    );
    final AuthService authService = context.read();
    authService.signIn(
      email: emailController.text,
      password: passwordController.text,
      onSuccess: () {
        if (mounted) {
          Toast.show(S.current.loginSuccess);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          );
          // Navigator.pop(context);
        }
      },
      onError: (err) {
        // 에러 발생
        Toast.show(err);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              Assets.lock,
              repeat: true,
              height: 150,
            ),
            const SizedBox(height: 20),

            //username
            SimpleTextField(
              controller: emailController,
              hintText: S.current.email,
              obscureText: false,
            ),
            const SizedBox(height: 15),

            //password
            SimpleTextField(
              controller: passwordController,
              hintText: S.current.pw,
              obscureText: true,
            ),
            const SizedBox(height: 20),

            //sign in button
            SimpleButton(
              onTap: onSignIn,
              text: S.current.signIn,
            ),
            const SizedBox(height: 20),

            //register
            _register(),
          ],
        ),
      ),
    );
  }

  Padding _register() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            S.current.notMember,
            style: TextStyle(color: context.color.subtext, fontSize: 12),
          ),
          const SizedBox(width: 4),
          GestureDetector(
            onTap: widget.onTap,
            child: Text(
              S.current.register,
              style: TextStyle(
                  color: context.color.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
