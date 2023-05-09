import 'package:get/state_manager.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

final stt = Stt().obs;

// N.B il metodo refresh() è analogo al setState(){}...
// cioè, è legato al metodo build(), quindi per gestire la grafica
// al variare del valore di una determinata informazione

class Stt {
  final SpeechToText sttInstance = SpeechToText();
  String _lastWords = "";
  String _lastError = "";
  String _lastStatus = "";

  String get getWords => _lastWords;
  String get getError => _lastError;
  String get getStatus => _lastStatus;

  Future<void> initSpeechState() async {
    await sttInstance.initialize(
        onError: errorListener, onStatus: statusListener);
  }

  void clear() {
    _lastWords = "";
    _lastError = "";
  }

  void recognizedWords(SpeechRecognitionResult result) {
    _lastWords = result.recognizedWords;

    stt.refresh();
  }


  ///
  /// RELATIVI ALL'INIT
  ///

  void errorListener(SpeechRecognitionError error) {
    _lastError = "${error.errorMsg} - ${error.permanent}";

    stt.refresh();
  }

  void statusListener(String status) {
    _lastStatus = status;

    stt.refresh();
  }
}
