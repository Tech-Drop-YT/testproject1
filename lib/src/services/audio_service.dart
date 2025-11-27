// FILE: lib/src/services/audio_service.dart

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

/// Service for managing game audio
class AudioService extends GetxService {
  final AudioPlayer _effectsPlayer = AudioPlayer();
  final AudioPlayer _musicPlayer = AudioPlayer();

  final RxBool soundEnabled = true.obs;
  final RxBool musicEnabled = true.obs;

  /// Initialize audio service
  Future<AudioService> init() async {
    await _effectsPlayer.setReleaseMode(ReleaseMode.stop);
    await _musicPlayer.setReleaseMode(ReleaseMode.loop);
    return this;
  }

  /// Play dice roll sound
  Future<void> playDiceRoll() async {
    if (!soundEnabled.value) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/dice_roll.mp3'));
    } catch (e) {
      // Sound file not found - silent fail for demo
    }
  }

  /// Play token move sound
  Future<void> playTokenMove() async {
    if (!soundEnabled.value) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/token_move.mp3'));
    } catch (e) {
      // Sound file not found - silent fail for demo
    }
  }

  /// Play kill sound
  Future<void> playKill() async {
    if (!soundEnabled.value) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/kill.mp3'));
    } catch (e) {
      // Sound file not found - silent fail for demo
    }
  }

  /// Play win sound
  Future<void> playWin() async {
    if (!soundEnabled.value) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/win.mp3'));
    } catch (e) {
      // Sound file not found - silent fail for demo
    }
  }

  /// Play button click sound
  Future<void> playButtonClick() async {
    if (!soundEnabled.value) return;
    try {
      await _effectsPlayer.play(AssetSource('sounds/button.mp3'));
    } catch (e) {
      // Sound file not found - silent fail for demo
    }
  }

  /// Toggle sound effects
  void toggleSound() {
    soundEnabled.value = !soundEnabled.value;
  }

  /// Toggle music
  void toggleMusic() {
    musicEnabled.value = !musicEnabled.value;
    if (musicEnabled.value) {
      _startMusic();
    } else {
      _stopMusic();
    }
  }

  /// Start background music
  Future<void> _startMusic() async {
    try {
      await _musicPlayer.play(AssetSource('sounds/background_music.mp3'));
    } catch (e) {
      // Music file not found - silent fail for demo
    }
  }

  /// Stop background music
  Future<void> _stopMusic() async {
    await _musicPlayer.stop();
  }

  @override
  void onClose() {
    _effectsPlayer.dispose();
    _musicPlayer.dispose();
    super.onClose();
  }
}
