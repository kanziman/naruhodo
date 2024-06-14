import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:naruhodo/util/custom/assets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.onInitializationDone});

  final Function onInitializationDone;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool animationTimeUp = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), () {}).then((value) {
      setState(() {
        animationTimeUp = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onInitializationDone(context);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedOpacity(
        opacity: animationTimeUp ? 1.0 : 0.0,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 1400),
        child: Container(
          width: double.infinity,
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: Lottie.asset(
            Assets.cat0,
            reverse: true,
            height: 70,
          ),
          // Image.asset(
          //   Assets.cat0,
          // ),
        ),
      ),
    );
  }
}
