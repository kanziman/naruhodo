import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/di/setup.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/src/service/lang_service.dart';
import 'package:naruhodo/src/service/theme_service.dart';
import 'package:naruhodo/util/ad/ad_manager.dart';
import 'package:naruhodo/util/ad/ad_navigator_observer.dart';
import 'package:naruhodo/util/lang/generated/l10n.dart';
import 'package:provider/provider.dart';

void main() async {
  await setupApp();
}

Future<void> setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  await AdManager.initialize(); // Initialize and load the ad

  await Firebase.initializeApp(); // Firebase 앱 초기화

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MultiProvider(
      providers: globalProviders,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: navigatorKey,
      navigatorObservers: [
        AdNavigatorObserver(authService: context.read<AuthService>())
      ],
      builder: (context, child) {
        return Overlay(
          initialEntries: [OverlayEntry(builder: (context) => child!)],
        );
      },
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context.watch<LangService>().locale,
      theme: context.themeService.themeData,
      initialRoute: RoutePath.splash,
      onGenerateRoute: RoutePath.onGenerateRoute,
    );
  }
}
