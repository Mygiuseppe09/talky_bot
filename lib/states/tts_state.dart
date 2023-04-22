import 'package:get/get.dart';
import 'package:text_to_speech/text_to_speech.dart';

final ttsState = TtsState().obs;

class TtsState {
  bool isPlaying = false;
  TextToSpeech ttsInstance = TextToSpeech();
  // le impostazioni che si possono regolare con questa libreria...
  String textToSpeech = ""; 
  double volume = 1.0; // where 0 is silence, and 1 is the maximum volume
  double rate = 1.0; // rate range: 0-2, 1.0 is the normal and default speech rate
  double pitch = 1.0; // pitch rate: 0-2, 1.0 is the normal pitch.. lower values lower the tone of the synthesized voice
  String? defaultLanguage = 'en-US';

//
// sotto i metodi per la gestione degli "stati" di questo package
//

Future<void> initLanguage() async { // metodo da invocare al primo avvio dell'app
  final String defaultLanguageCode = await ttsInstance.getDefaultLanguage() as String;
  defaultLanguage = await ttsInstance.getDisplayLanguageByCode(defaultLanguageCode);
  
  ttsState.refresh();
}

void play()  {
  isPlaying = true;
  ttsState.refresh();

  ttsInstance.speak(textToSpeech);
}

void stop() {
  isPlaying = false;
  ttsState.refresh();

  ttsInstance.stop();
}

void setVolume(double newValue) {
  volume = newValue;
  ttsState.refresh();
}

void setRate(double newRate) {
  rate = newRate;
  ttsState.refresh();
}

void setPitch(double newPitch) {
  pitch = newPitch;
  ttsState.refresh();
}

  
}

