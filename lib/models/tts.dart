import 'package:get/get.dart';
import 'package:text_to_speech/text_to_speech.dart';

final tts = Tts().obs;

class Tts {
  TextToSpeech ttsInstance = TextToSpeech();
  bool isPlaying = false;
  String text = "";
  double volume = 1.0; // where 0 is silence, and 1 is the maximum volume
  double rate =
      1.0; // rate range: 0-2, 1.0 is the normal and default speech rate
  double pitch =
      1.0; // pitch rate: 0-2, 1.0 is the normal pitch.. lower values lower the tone of the synthesized voice
  String? defaultLanguage = 'en-US';

//
// sotto i metodi per la gestione degli "stati" di questa libreria
//

  Future<void> initLanguage() async {
    // metodo da invocare al primo avvio dell'app
    final String defaultLanguageCode =
        await ttsInstance.getDefaultLanguage() as String;
    defaultLanguage =
        await ttsInstance.getDisplayLanguageByCode(defaultLanguageCode);

    tts.refresh();
  }

  void play() {
    isPlaying = true;
    tts.refresh();

    ttsInstance.speak(text);
  }

  void stop() {
    isPlaying = false;
    tts.refresh();

    ttsInstance.stop();
  }

  void setVolume(double newValue) {
    volume = newValue;
    tts.refresh();
  }

  void setRate(double newRate) {
    rate = newRate;
    tts.refresh();
  }

  void setPitch(double newPitch) {
    pitch = newPitch;
    tts.refresh();
  }
}
