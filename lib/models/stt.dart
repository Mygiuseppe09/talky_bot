import 'package:TalkyBot/components/my_large_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

final stt = Stt().obs;

// N.B il metodo refresh() è analogo al setState(){}...
// cioè, è legato al metodo build(), quindi per gestire la grafica
// al variare del valore di una determinata informazione

class Stt {
  final SpeechToText _sttInstance = SpeechToText();
  String _lastWords = "";
  String _lastError = "";
  String _lastStatus = "";
  double _inputLevel = 0.0;

  SpeechToText get getInstance => _sttInstance;
  String get getWords => _lastWords;
  String get getError => _lastError;
  String get getStatus => _lastStatus;
  double get getVoiceLevelInput => _inputLevel > 2 ? _inputLevel/10 : 0;

  Future<void> initSpeechState() async {
    await _sttInstance.initialize(
        onError: errorListener, onStatus: statusListener);
  }

  void setCurrentInputLevel(double level) {
    _inputLevel = level;

    stt.refresh();
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

  ///
  /// Dialogs
  ///

  static Widget _boldText(String text) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      );

  static Widget _continueButton(BuildContext context) => MyLargeElevatedButton(
        backgroundColor: Colors.green.shade200,
        foregroundColor: Colors.green.shade900,
        text: "CONTINUA",
        onPressed: () => Navigator.pop(context),
      );

  static void showPermissionGrantedDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset("animated/lottie_ok.json"),
                  _boldText("Permessi microfono ottenuti!"),
                  _continueButton(context),
                ],
              ),
            ),
          ));
}
