import 'package:flutter/material.dart';
import 'package:naruhodo/src/model/query_request.dart';
import 'package:naruhodo/src/model/voca.dart';
import 'package:naruhodo/src/view/login/sign_page.dart';
import 'package:naruhodo/src/pages/enter_page.dart';
import 'package:naruhodo/src/pages/home_page.dart';
import 'package:naruhodo/src/pages/on_boarding_page.dart';
import 'package:naruhodo/src/pages/review_page.dart';
import 'package:naruhodo/src/pages/splash_page.dart';
import 'package:naruhodo/theme/component/constrained_screen.dart';

abstract class RoutePath {
  static const String home = 'home';
  static const String auth = 'auth';
  static const String enter = 'enter';
  static const String admin = 'admin';
  static const String splash = 'splash';
  static const String onBoarding = 'onBoarding';
  static const String review = 'review';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePath.auth:
        return _buildRoute(settings, const SignPage());
      case RoutePath.home:
        return _buildRoute(settings, const HomePage());
      case RoutePath.enter:
        return _buildEnterRoute(settings);
      case RoutePath.review:
        return _buildReviewRoute(settings);
      case RoutePath.onBoarding:
        return _buildRoute(settings, const OnBoardingPage());
      case RoutePath.splash:
        return _buildSplashRoute(settings);
      default:
        throw const FormatException("Route not found");
    }
  }

  static MaterialPageRoute _buildRoute(RouteSettings settings, Widget page) {
    return MaterialPageRoute(
      builder: (context) => ConstrainedScreen(child: page),
      settings: settings,
    );
  }

  static MaterialPageRoute _buildEnterRoute(RouteSettings settings) {
    final queryRequest = settings.arguments as QueryRequest;
    final page = LearningPage(queryRequest: queryRequest);
    return _buildRoute(settings, page);
  }

  static MaterialPageRoute _buildReviewRoute(RouteSettings settings) {
    final args = settings.arguments as Map<String, dynamic>;
    final vocaList = args['vocaList'] as List<Voca>;
    final level = args['key'] as int;
    final startPoint = args['point'] as int;
    final page =
        ReviewPage(level: level, vocaList: vocaList, point: startPoint);
    return _buildRoute(settings, page);
  }

  static MaterialPageRoute _buildSplashRoute(RouteSettings settings) {
    final splashPage = SplashPage(
      onInitializationDone: (ctx) {
        Navigator.pushReplacementNamed(ctx, RoutePath.onBoarding);
      },
    );
    final constrainedSplash = ConstrainedScreen(child: splashPage);
    return MaterialPageRoute(
      builder: (context) => constrainedSplash,
      settings: settings,
    );
  }
}
