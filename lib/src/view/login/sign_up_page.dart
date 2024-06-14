import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/src/pages/home_page.dart';
import 'package:naruhodo/src/widgets/simple/simple_button.dart';
import 'package:naruhodo/src/widgets/simple/simple_textfield.dart';
import 'package:naruhodo/theme/component/toast/toast.dart';
import 'package:naruhodo/util/custom/assets.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

class SignupView extends StatefulWidget {
  final Function()? onTap;
  const SignupView({super.key, required this.onTap});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      // check if both password and confirm pasword is same
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        //show error password dont match
        genericErrorMessage("Password don't match!");
      }
      if (!mounted) return;
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      //pop the loading circle
      Navigator.pop(context);

      genericErrorMessage(e.code);
    }
  }

  void genericErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void onSignUp() {
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
    authService.signUp(
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      onSuccess: () {
        if (mounted) {
          Toast.show(S.current.signUpSuccess);
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
        if (mounted) {
          // 에러 발생
          Toast.show(err);
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          const SizedBox(height: 15),

          SimpleTextField(
            controller: confirmPasswordController,
            hintText: S.current.confirmPw,
            obscureText: true,
          ),
          const SizedBox(height: 20),

          //sign in button
          SimpleButton(
            onTap: onSignUp,
            text: S.current.signUp,
          ),
          const SizedBox(height: 20),

          // continue with
          // _social(),

          // not a memeber ? register now
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.current.alreadyAccount,
                style: TextStyle(color: context.color.subtext, fontSize: 12),
              ),
              const SizedBox(
                width: 6,
              ),
              GestureDetector(
                onTap: widget.onTap,
                child: Text(
                  S.current.loginNow,
                  style: TextStyle(
                      color: context.color.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _social() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Text(
                  'OR',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              Expanded(
                child: Divider(
                  thickness: 0.5,
                  color: Colors.grey.shade400,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),

        //google + apple button
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     //google buttom
        //     SquareTile(
        //       onTap: () => AuthService().signInWithGoogle(),
        //       imagePath: 'assets/icons/google.svg',
        //       height: 70,
        //     ),
        //     const SizedBox(width: 20),
        //     // apple buttom
        //     SquareTile(
        //       onTap: () {},
        //       imagePath: 'assets/icons/apple.svg',
        //       height: 70,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
