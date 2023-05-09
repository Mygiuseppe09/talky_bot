import 'package:ToSpeak/components/my_icon_button.dart';
import 'package:ToSpeak/components/my_large_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ToSpeak/models/chronology.dart';
import 'package:ToSpeak/models/tts.dart';
import 'package:ToSpeak/models/stt.dart';
import 'package:lottie/lottie.dart';
import 'package:open_apps_settings/open_apps_settings.dart';
import 'package:open_apps_settings/settings_enum.dart';

class TtsttBody extends StatefulWidget {
  @override
  State<TtsttBody> createState() => _TtsttBodyState();
}

class _TtsttBodyState extends State<TtsttBody> {
  final TextEditingController textController = TextEditingController();

  void onPlayPressed() {
    // recupero testo dal controller
    final String text = textController.text.trim();

    tts.value.play(text);

    // salvare il testo nella cronologia
    if (text.isNotEmpty && !chronology.value.chronologyList.contains(text)) {
      chronology.value.addNew(text);
      GetStorage().write("chronology", chronology.value.chronologyList);
    }
  }

  void onStopPessed() => tts.value.stop();


  void onMicPressed(BuildContext context) {
    if (stt.value.sttInstance.isAvailable) {
      stt.value.clear();
      stt.value.sttInstance
          .listen(onResult: (result) => stt.value.recognizedWords(result));
      showDialog(
          // disattiviamo il tap fuori dal dialog per uscire
          barrierDismissible: false,
          context: context,
          builder: (context) => Dialog(
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    // il contenuto varia in funzione del listen
                    child: Obx(
                      () => stt.value.sttInstance.isListening
                          ? Column(mainAxisSize: MainAxisSize.min, children: [
                              listeningGif(),
                              showListenedText(),
                              SizedBox(height: 20), // separè
                            ])

                          // se non sta ascoltando ma il testo è vuoto
                          : stt.value.getWords.isEmpty &&
                                  !stt.value.sttInstance.hasRecognized
                              ? Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    sorryIcon(),
                                    boldText("Non sono riuscito a sentirti..."),
                                    retryButton(),
                                    cancelButton(),
                                  ],
                                )

                              // ha finito di ascoltare e l'utente ha parlato
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    showListenedText(),
                                    confirmButton(),
                                    SizedBox(height: 15),
                                    Divider(),
                                    retryButton(),
                                    cancelButton()
                                  ],
                                ),
                    )),
              ));
    } else {
      // Riconoscimento non disponibile
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: speechToTextNotAvailable(),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 70,
          title: Text(
            "Inserisci qui sotto il testo da sintetizzare",
            style: TextStyle(fontSize: 16),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(children: [
              Card(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 10),
                elevation: 5,
                child: Container(
                  margin: EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    minLines: null,
                    maxLines: null,
                    expands: true,
                    style: TextStyle(color: Colors.grey.shade800),
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    controller: textController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 10,
                child: MyIconButton(
                  icon: Icons.mic,
                  onPressed: () => onMicPressed(context),
                  size: 40,
                ),
              ),
            ]),
          ),
          Obx(
            () => MyIconButton(
              icon: tts.value.isPlaying ? Icons.stop : Icons.play_arrow,
              onPressed: tts.value.isPlaying ? onStopPessed : onPlayPressed,
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  ///
  ///
  /// ************ componenti grafici e logici dei Dialogs *******************
  ///
  ///

  Widget boldText(String text) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      );

  Widget sorryIcon() => Image.asset(
        "images/bad_bot.png",
        width: 250,
        height: 250,
      );

  Widget listeningGif() => Image.asset(
        // gif orecchio in ascolto
        "animated/ear.gif",
        width: 120,
        height: 120,
      );

  Widget confirmButton() => MyLargeElevatedButton(
      backgroundColor: Colors.green.shade200,
      foregroundColor: Colors.green.shade900,
      text: "Usa testo",
      // pulsante conferma
      onPressed: () {
        textController.text += "${stt.value.getWords} ";
        Navigator.pop(context);
      });

  Widget retryButton() => MyLargeElevatedButton(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      text: "Ripeti",
      onPressed: () {
            stt.value.clear();
            stt.value.sttInstance.listen(
                onResult: (result) => stt.value.recognizedWords(result));
          }
      );


  Widget cancelButton() => MyLargeElevatedButton(
      backgroundColor: Colors.red.shade100,
      foregroundColor: Colors.red.shade900,
      text: "Annulla",
      onPressed: () {
        Navigator.pop(context);
        stt.value.sttInstance.cancel();
        stt.value.clear();
      });

  Widget showListenedText() => Padding(
        padding: const EdgeInsets.all(24.0),
        child: Text(
          stt.value.getWords,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      );

  Widget continueButton() => MyLargeElevatedButton(
        backgroundColor: Colors.green.shade200,
        foregroundColor: Colors.green.shade900,
        text: "CONTINUA",
        onPressed: () => Navigator.pop(context),
      );

  showPermissionGrantedDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Lottie.asset("animated/lottie_ok.json"),
                  boldText("Permessi microfono ottenuti!"),
                  continueButton(),
                ],
              ),
            ),
          ));

  Widget onAppSettingButton() => MyLargeElevatedButton(
        backgroundColor: Colors.green.shade200,
        foregroundColor: Colors.green.shade900,
        text: "Apri impostazioni",
        onPressed: () {
          OpenAppsSettings.openAppsSettings(
            settingsCode: SettingsCode.APP_SETTINGS,
            onCompletion: () {
              Navigator.pop(context);
              stt.value.initSpeechState().then((_) {
                if (stt.value.sttInstance.isAvailable) {
                  showPermissionGrantedDialog(context);
                }
              });
            },
          );
        },
      );

  Widget speechToTextNotAvailable() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            sorryIcon(),
            boldText("Servizio non disponibile..."),
            Text(
              "Probabilmente non mi hai dato i permessi d'uso del microfono",
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            onAppSettingButton(),
            cancelButton(),
          ],
        ),
      );
}