import 'dart:io' show Platform;

// final String adUnitId = Platform.isAndroid
//     ? 'ca-app-pub-3521131839555647/5323991516'
//     : 'ca-app-pub-3521131839555647/4900986541';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3521131839555647/5323991516';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3521131839555647/4900986541';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3521131839555647/2971244627";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3521131839555647/2406685145";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  ///TESTER
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
