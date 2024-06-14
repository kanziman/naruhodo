import 'package:flutter/material.dart';
import 'package:naruhodo/main.dart';
import 'package:naruhodo/theme/component/toast/toast_builder.dart';

abstract class Toast {
  static void show(
    String text, {
    Duration duration = const Duration(seconds: 2),
  }) async {
    BuildContext? context = MyApp.navigatorKey.currentContext;
    if (context == null) return;

    GlobalKey<ToastBuilderState> toastKey = GlobalKey();

    /// Insert
    final overlay = Overlay.of(context);
    const animDuration = Duration(milliseconds: 333);
    final toast = OverlayEntry(
      builder: (context) {
        return ToastBuilder(
          key: toastKey,
          animDuration: animDuration,
          text: text,
        );
      },
    );
    overlay.insert(toast);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      toastKey.currentState?.isShow = true;
    });

    /// Remove
    await Future.delayed(duration);
    toastKey.currentState?.isShow = false;
    await Future.delayed(animDuration);
    toast.remove();
  }
}
