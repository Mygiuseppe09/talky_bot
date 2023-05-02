import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ToSpeak/models/chronology.dart';
import 'package:ToSpeak/models/tts.dart';

class TtsBody extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  void onPlayPressed() async {
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
              child: Card(
            margin: EdgeInsets.only(left: 20, right: 20, top: 1, bottom: 15),
            elevation: 5,
            child: Container(
              margin: EdgeInsets.all(10),
              color: Colors.white,
              child: TextField(
                style: TextStyle(color: Colors.grey.shade800),
                cursorColor: Colors.black,
                keyboardType: TextInputType.text,
                controller: textController,
                maxLines: 30,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          )),
          Obx(
            () => Container(
              // Pulsante Play/Stop
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              height: 60,
              width: 60,
              child: IconButton(
                onPressed: tts.value.isPlaying ? onStopPessed : onPlayPressed,
                icon: Icon(
                  tts.value.isPlaying ? Icons.stop : Icons.play_arrow,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
