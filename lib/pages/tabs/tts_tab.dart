import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_speak/states/history_state.dart';
import 'package:to_speak/states/tts_state.dart';
import 'package:get_storage/get_storage.dart';

class TtsBody extends StatelessWidget {
  final GetStorage storage = GetStorage();
  final TextEditingController textController = TextEditingController();


  void onPlayPressed() {
    // recupero testo dal controller
    final String text = textController.text.trim();

    // preparo le impostazione e parte lo speaker
    ttsState.value.textToSpeech = text;
    ttsState.value.ttsInstance.setVolume(ttsState.value.volume);
    ttsState.value.ttsInstance.setRate(ttsState.value.rate);
    ttsState.value.ttsInstance.setPitch(ttsState.value.pitch);
    ttsState.value.play();

    // salvare il testo nella cronologia
    if (text.isNotEmpty && !historyState.value.searchHistoryList.contains(text)) {
    historyState.value.addNew(text);
    storage.write("history", historyState.value.searchHistoryList);
    }
  }

  void onStopPessed () => ttsState.value.stop();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
  onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // per nascondere la tastiera al click fuori dall'input del testo
    child: Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text("Inserisci qui sotto il testo da sintetizzare", style: TextStyle(fontSize: 18),)
        ),

      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              elevation: 10,
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
              )
            ),
            Obx(() => Container( // Pulsante Play/Stop
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
              height: 60,
              width: 60,
              child: IconButton(
                onPressed: ttsState.value.isPlaying ? onStopPessed : onPlayPressed, 
                icon: Icon(ttsState.value.isPlaying ? Icons.stop : Icons.play_arrow, 
                size: 30, 
                color: Colors.white,),
              ),
            ),
          ), 
            SizedBox(height: 20,)
          ],
        ),
      ),
  );
  }
}