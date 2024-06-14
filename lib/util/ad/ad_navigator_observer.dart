import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:naruhodo/route/route_path.dart';
import 'package:naruhodo/src/service/auth_service.dart';
import 'package:naruhodo/util/ad/ad_manager.dart';

class AdNavigatorObserver extends NavigatorObserver {
  late AuthService authService;

  AdNavigatorObserver({required this.authService});

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    // 광고 로드 상태를 확인
    if (AdManager.isAdLoaded && AdManager.ad != null) {
      var interstitialAd = AdManager.ad;
      log('AdNavigatorObserver didpop? $authService.userData');
      if ((authService.userData?['isAdmin'] ?? false) == true) {
        return;
      }

      if (previousRoute is MaterialPageRoute &&
          route is MaterialPageRoute &&
          interstitialAd != null) {
        if (route.settings.name == 'enter') {
          interstitialAd.show();
          AdManager.isAdLoaded = false; // 광고를 보여준 후 로드 상태를 업데이트
        }
      }
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    // 광고 로드 상태를 확인
    if (AdManager.isAdLoaded && AdManager.ad != null) {
      var interstitialAd = AdManager.ad;
      if (oldRoute?.settings.name == RoutePath.enter) {
        interstitialAd?.show();
        AdManager.isAdLoaded = false; // 광고를 보여준 후 로드 상태를 업데이트
      }
    }
  }
}
