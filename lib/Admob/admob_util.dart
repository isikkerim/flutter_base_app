import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

final adUnitId = Platform.isAndroid
    ? 'ca-app-pub-3940256099942544/1033173712'
    : 'ca-app-pub-3940256099942544/4411468910';
InterstitialAd? _fullScreenAd;
RewardedAd? _rewardedAd;
Timer? _adReloadTimer;
bool _isAdLoaded = false; // Reklamın yüklenip yüklenmediğini izleyen değişken

class AdvertisingService {
  // Timer'ı başlatan fonksiyon
  void startAdReloadTimer() {
    _adReloadTimer = Timer.periodic(const Duration(seconds: 45), (timer) {
      if (!_isAdLoaded) {
        // Eğer reklam yüklü değilse
        print("45 saniye geçti, reklam yükleniyor...");
        loadFullScreenAdvertising(); // Reklamı yeniden yüklüyor
      } else {
        print("Reklam zaten yüklü, yeniden yüklemeye gerek yok.");
      }
    });
  }

  // Timer'ı durduran fonksiyon
  void cancelAdReloadTimer() {
    _adReloadTimer?.cancel(); // Timer'ı iptal ediyoruz
  }

  void loadFullScreenAdvertising() {
    InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            _isAdLoaded = true; // Reklam başarıyla yüklendi

            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {});

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _fullScreenAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  void showFullScreenAdvertising() {
    if (_fullScreenAd != null) {
      _fullScreenAd!.show();
      _fullScreenAd = null; // Reklam gösterildikten sonra null olarak ayarlanır
    } else {
      print('Reklam henüz yüklenmedi veya zaten gösterildi.');
    }
  }

  void loadRewardedAd() {
    RewardedAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/5224354917',
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('Rewarded Ad yüklendi.');
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              debugPrint('Rewarded Ad gösteriliyor.');
            },
            onAdImpression: (ad) {
              debugPrint('Rewarded Ad gösterimi kaydedildi.');
            },
            onAdFailedToShowFullScreenContent: (ad, err) {
              debugPrint('Rewarded Ad gösterilemedi: $err');
              ad.dispose();
              _rewardedAd = null; // Hata durumunda reklamı null yapın
            },
            onAdDismissedFullScreenContent: (ad) {
              debugPrint('Rewarded Ad kapatıldı.');
              ad.dispose();
              _rewardedAd = null; // Reklam kapandıktan sonra null yapın
            },
            onAdClicked: (ad) {
              debugPrint('Rewarded Ad tıklandı.');
            },
          );

          _rewardedAd = ad; // Reklam yüklendiğinde referans ayarlanır
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Rewarded Ad yüklenemedi: $error');
        },
      ),
    );
  }

  void showRewardedAdvertising() {
    if (_rewardedAd != null) {
      _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          print("Ödül kazanıldı: ${reward.amount} ${reward.type}");
        },
      );
      debugPrint('Rewarded Ad gösterildi.');
      _rewardedAd = null; // Reklam gösterildikten sonra null yapın
    } else {
      print(
          'Ödüllü reklam henüz yüklenmedi veya gösterilemedi.'); // Yüklenmemişse uyarı verir
      loadRewardedAd(); // Reklamı tekrar yükleyin
    }
  }

  void dispose() {
    cancelAdReloadTimer();
    _fullScreenAd?.dispose();
    _rewardedAd?.dispose();
  }


}

class AdHelper {

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/6300978111';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/2934735716';
    }
    throw UnsupportedError("Unsupported platform");
  }

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-3940256099942544/2247696110';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-3940256099942544/3986624511';
    }
    throw UnsupportedError("Unsupported platform");
  }
}