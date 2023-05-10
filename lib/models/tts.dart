import 'package:get/get.dart';
import 'package:text_to_speech/text_to_speech.dart';

final tts = Tts().obs;

class Tts {
  final TextToSpeech _ttsInstance = TextToSpeech();
  double _volume = 1.0; // where 0 is silence, and 1 is the maximum volume
  double _rate = 1.0; // rate range: 0-2, 1.0 is the default speech rate
  double _pitch = 1.0; // pitch rate: 0-2, 1.0 is the normal pitch
  String? _defaultLanguage = 'en-US';
  bool _isPlaying = false;

  double get getVolume => _volume;
  double get getRate => _rate;
  double get getPitch => _pitch;
  String? get getLanguage => _defaultLanguage;
  bool get isPlaying => _isPlaying;

  ///
  /// sotto i metodi per la gestione degli "stati" di questa libreria
  ///

  Future<void> initLanguage() async {
    // metodo da invocare al primo avvio dell'app
    final String defaultLanguageCode =
        await _ttsInstance.getDefaultLanguage() as String;
    _defaultLanguage =
        await _ttsInstance.getDisplayLanguageByCode(defaultLanguageCode);

    tts.refresh();
  }

  void play(String text) {
    _isPlaying = true;
    tts.refresh();

    _ttsInstance.setVolume(_volume);
    _ttsInstance.setPitch(_pitch);
    _ttsInstance.setRate(_rate);
    _ttsInstance.speak(text);
  }

  void stop() {
    _isPlaying = false;
    tts.refresh();

    _ttsInstance.stop();
  }

  void setVolume(double newValue) {
    _volume = newValue;
    tts.refresh();
  }

  void setRate(double newRate) {
    _rate = newRate;
    tts.refresh();
  }

  void setPitch(double newPitch) {
    _pitch = newPitch;
    tts.refresh();
  }
}
