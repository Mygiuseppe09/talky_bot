import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_speak/states/tts_state.dart';

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> // rendiamo il tutto "osservabile" per gestire i cambiamenti 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox( // icona robottino
              width: 170,
              height: 170,
              child: Image.asset("images/bot.png"),
            ),
            
            SizedBox(height: 30,), // un po' di distanza


            Column( // blocco volume
              children: [
                ListTile(
                  leading: Icon(Icons.volume_down, size: 60),
                  title: Text("Volume"),
                  subtitle: Text("regola il volume del lettore artificiale"),
                  trailing: Text((ttsState.value.volume * 100).toStringAsFixed(0)),
                ),
                FractionallySizedBox (
                  widthFactor: 0.9,
                  child: Slider(
                    thumbColor: Colors.black, // colore pallino
                    activeColor: Colors.black, // colore parte piena
                    inactiveColor: Colors.grey.shade300, // colore parte mancante
                    min: 0,
                    max: 1,
                    value: ttsState.value.volume, 
                    onChanged: (value) => ttsState.value.setVolume(value),
                  ),
                )
              ],
            ),

            Column( // blocco velocità "rate"
              children: [
                ListTile(
                  leading: Icon(Icons.speed, size: 60),
                  title: Text("Velocità"),
                  subtitle: Text("regola la velocità con cui parla l'assistente"),
                  trailing: Text((ttsState.value.rate * 50).toStringAsFixed(0),),
                ),
                FractionallySizedBox (
                  widthFactor: 0.9,
                  child: Slider(
                    thumbColor: Colors.black, // colore pallino
                    activeColor: Colors.black, // colore parte piena
                    inactiveColor: Colors.grey.shade300, // colore parte mancante
                    min: 0,
                    max: 2,
                    value: ttsState.value.rate, 
                    onChanged: (value) => ttsState.value.setRate(value),
                  ),
                )
              ],
            ),

            Column( // blocco tono "pitch"
              children: [
                ListTile(
                  leading: Icon(Icons.mic, size: 60),
                  title: Text("Tono"),
                  subtitle: Text("l'assistente riesce a cambiare tonalità: regolala!"),
                  trailing: Text((ttsState.value.pitch * 50).toStringAsFixed(0)),
                ),
                FractionallySizedBox (
                  widthFactor: 0.9,
                  child: Slider(
                    thumbColor: Colors.black, // colore pallino
                    activeColor: Colors.black, // colore parte piena
                    inactiveColor: Colors.grey.shade300, // colore parte mancante
                    min: 0,
                    max: 2,
                    value: ttsState.value.pitch, 
                    onChanged: (value) => ttsState.value.setPitch(value),
                  ),
                )
              ],
            ),

          ],
        ),
      ),
    ), 
      backgroundColor: Colors.white,
    );
  }
}