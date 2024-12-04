import 'package:audioplayers/audioplayers.dart';
import 'package:vibration/vibration.dart';

class AudioVibrationService {
  // AudioPlayer nesnesi
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Ses dosyasının yolu



  // Ses çalma metodu
  Future<void> playSound() async {
    try {
      // Ses dosyasını çalma
      final player = AudioPlayer();
      await player.play(AssetSource('voices/magic.mp3'));
    } catch (e) {
      print("Ses çalarken hata oluştu: $e");
    }
  }

  // Ses durdurma metodu
  Future<void> stopSound() async {
    await _audioPlayer.stop();
  }

  // Titreşim uygulama metodu
  Future<void> vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 500); // 500 ms süreyle titreşim
    } else {
      print("Cihazda titreşim motoru yok.");
    }
  }

  // Ses ve titreşim uygulama metodu
  Future<void> playSoundAndVibrate() async {
    await playSound();
    await vibrate();
  }
}