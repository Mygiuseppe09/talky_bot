import 'dart:developer';

import 'package:TalkyBot/components/my_icon_button.dart';
import 'package:TalkyBot/components/my_large_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:TalkyBot/models/chronology.dart';
import 'package:TalkyBot/models/tts.dart';
import 'package:TalkyBot/models/stt.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';
import 'package:open_apps_settings/open_apps_settings.dart';
import 'package:open_apps_settings/settings_enum.dart';
import 'package:progresso/progresso.dart';

class TtsttBody extends StatefulWidget {
  @override
  State<TtsttBody> createState() => _TtsttBodyState();
}

/// il testo "corrente" non è all'interno della classe "State" perchè,
/// è si una variabile di stato, ma vogliamo che la sua informazione permanga
/// anche quando l'intero tab è rimosso dal "tree"
String currentText = '';

class _TtsttBodyState extends State<TtsttBody> {
  final TextEditingController textController = TextEditingController();

  @override
  void initState() { // recuperiamo il testo che l'utente stava scrivendo
    /// essendo questa pagina un tab,
    /// è chiamato ogni qualvolta il tab è visualizzato
    textController.text = currentText;
    super.initState();
  }

  @override
  void dispose() { // salviamo il testo che l'utente sta scrivendo
    /// è chiamato ogni qualvolta il tab NON è visualizzato
    currentText = textController.text;
    super.dispose();
  }

  void onPlayPressed() {
    // recupero testo dal controller
    currentText = textController.text.trim();

    if (currentText.isEmpty) {
      // l'utente ha tappato play senza che ci sia alcun testo
      tts.value.speakEmptyError();
    } else {
      tts.value.play(currentText);

      // salvare il testo nella cronologia
      if (!chronology.value.getChronologyList.contains(currentText)) {
        chronology.value.addNew(currentText);
        GetStorage().write("chronology", chronology.value.getChronologyList);
      }
    }
  }

  void onStopPessed() => tts.value.stop();

  void startListening() {
    stt.value.clear();
    stt.value.getInstance.listen(
      onResult: (result) => stt.value.recognizedWords(result),
      onSoundLevelChange: (level) => stt.value.setCurrentInputLevel(level),
    );
  }

  void onMicPressed(BuildContext context) {
    if (stt.value.getInstance.isAvailable) {
      startListening();
      showDialog(
          // disattiviamo il tap fuori dal dialog per uscire
          barrierDismissible: false,
          context: context,
          builder: (context) => StreamBuilder<InternetConnectionStatus>(
              stream: InternetConnectionChecker().onStatusChange,
              builder: (context, snapshot) {
                return Dialog(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      // il contenuto varia a seconda se l'app sta ascoltando
                      child: Obx(
                        () => stt.value.getInstance.isListening &&
                                stt.value.getStatus.contains("listening")
                            ? Column(mainAxisSize: MainAxisSize.min, children: [
                                if (snapshot.data ==
                                    InternetConnectionStatus.disconnected)
                                  noInternetAlert(),
                                listenedText(context),
                                SizedBox(height: 20),
                                listeningMicAnimate(), // separè
                              ])

                            // se non sta ascoltando ma il testo è vuoto
                            : stt.value.getWords.isEmpty &&
                                    stt.value.getStatus.contains("done")
                                ? Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      sorryIcon(),
                                      boldText(
                                          "Non sono riuscito a sentirti..."),
                                      retryButton(),
                                      cancelButton(),
                                    ],
                                  )

                                // ha finito di ascoltare e l'utente ha parlato
                                : Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      listenedText(context),
                                      confirmButton(),
                                      SizedBox(height: 15),
                                      Divider(),
                                      retryButton(),
                                      cancelButton()
                                    ],
                                  ),
                      )),
                );
              }));
    } else {
      // Riconoscimento non disponibile
      showDialog(
          context: context,
          builder: (context) => Dialog(
                child: FocusDetector(
                    onFocusLost: () {
                      // siamo usciti dall'app mentre è aperto il Dialog d'errore
                      Navigator.pop(context);
                    },
                    child: speechToTextNotAvailable()),
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

  Widget noInternetAlert() => Column(
        children: [
          Stack(
            children: [
              Lottie.asset(
                "animated/no_internet.json",
                width: double.infinity,
                height: 180,
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 30,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child:
                        Center(child: Text("l'accuratezza potrebbe diminuire")),
                  )),
            ],
          ),
          SizedBox(height: 30)
        ],
      );

  Widget boldText(String text) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      );

  Widget sorryIcon() => Image.asset(
        "images/bad_bot.png",
        width: 250,
        height: 250,
      );

  Widget listeningMicAnimate() => Row(
        children: [
          Icon(Icons.mic),
          SizedBox(width: 10),
          Expanded(
            child: Progresso(
              backgroundColor: Colors.grey,
              progressColor: Colors.black,
              progress: stt.value.getVoiceLevelInput,
            ),
          ),
          SizedBox(width: 5),
        ],
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
        onPressed: () => startListening(),
      );

  Widget cancelButton() => MyLargeElevatedButton(
      backgroundColor: Colors.red.shade100,
      foregroundColor: Colors.red.shade900,
      text: "Annulla",
      onPressed: () {
        Navigator.pop(context);
        stt.value.getInstance.cancel();
        stt.value.clear();
      });

  Widget listenedText(BuildContext context) =>
      Obx(() => stt.value.getWords.length > 150
          ? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    // SingleChildScrollView should be
                    // wrapped in an Expanded Widget
                    scrollDirection: Axis.vertical,
                    child: Text(
                      stt.value.getWords,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  )),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                stt.value.getWords,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ));

  Widget continueButton() => MyLargeElevatedButton(
        backgroundColor: Colors.green.shade200,
        foregroundColor: Colors.green.shade900,
        text: "CONTINUA",
        onPressed: () => Navigator.pop(context),
      );

  Widget onAppSettingButton() => MyLargeElevatedButton(
        backgroundColor: Colors.green.shade200,
        foregroundColor: Colors.green.shade900,
        text: "Apri impostazioni",
        onPressed: () {
          OpenAppsSettings.openAppsSettings(
            settingsCode: SettingsCode.APP_SETTINGS,
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
