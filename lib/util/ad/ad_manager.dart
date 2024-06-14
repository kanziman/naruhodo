import 'dart:developer';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:naruhodo/util/ad/ad_helper.dart';

class AdManager {
  static InterstitialAd? _interstitialAd;
  static bool isAdLoaded = false;

  static Future<void> initialize() async {
    await MobileAds.instance.initialize();
    loadInterstitialAd();
  }

  static void loadInterstitialAd() async {
    await InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          isAdLoaded = true;

          _interstitialAd!.fullScreenContentCallback =
              FullScreenContentCallback(
                  onAdDismissedFullScreenContent: (InterstitialAd ad) {
            ad.dispose();
            log('Ad new.');
            loadInterstitialAd(); // Reload a new ad when the current one is closed
          }, onAdFailedToShowFullScreenContent:
                      (InterstitialAd ad, AdError error) {
            log('Ad failed to show.');
            ad.dispose();
            loadInterstitialAd(); // Attempt to load a new ad if the current one fails to show
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          log('Failed to load an interstitial ad: ${error.message}');
          isAdLoaded = false;
        },
      ),
    );
  }

  static InterstitialAd? get ad => isAdLoaded ? _interstitialAd : null;
}
