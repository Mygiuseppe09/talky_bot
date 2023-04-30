import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_speak/models/tts.dart';
import 'package:to_speak/pages/license_attribution.dart';

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => LicenseAndAttribution())),
        backgroundColor: Colors.black,
          child: Icon(Icons.question_mark, color: Colors.white),
        ),
      body: Obx(() => // rendiamo il tutto "osservabile" per gestire i cambiamenti 
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            SizedBox( // icona robottino
              width: 150,
              height: 150,
              child: Image.asset("images/bot.png"),
            ),
            
            SizedBox(height: 20,), // un po' di distanza

            Column( // blocco volume
              children: [
                ListTile(
                  leading: Icon(Icons.volume_down, size: 60),
                  title: Text("Volume"),
                  subtitle: Text("regola il volume del lettore artificiale"),
                  trailing: Text((tts.value.volume * 100).toStringAsFixed(0)),
                ),
                FractionallySizedBox (
                  widthFactor: 0.9,
                  child: Slider(
                    thumbColor: Colors.black, // colore pallino
                    activeColor: Colors.black, // colore parte piena
                    inactiveColor: Colors.grey.shade300, // colore parte mancante
                    min: 0,
                    max: 1,
                    value: tts.value.volume, 
                    onChanged: (value) => tts.value.setVolume(value),
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
                  trailing: Text((tts.value.rate * 50).toStringAsFixed(0),),
                ),
                FractionallySizedBox (
                  widthFactor: 0.9,
                  child: Slider(
                    thumbColor: Colors.black, // colore pallino
                    activeColor: Colors.black, // colore parte piena
                    inactiveColor: Colors.grey.shade300, // colore parte mancante
                    min: 0,
                    max: 2,
                    value: tts.value.rate, 
                    onChanged: (value) => tts.value.setRate(value),
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
                  trailing: Text((tts.value.pitch * 50).toStringAsFixed(0)),
                ),
                FractionallySizedBox (
                  widthFactor: 0.9,
                  child: Slider(
                    thumbColor: Colors.black, // colore pallino
                    activeColor: Colors.black, // colore parte piena
                    inactiveColor: Colors.grey.shade300, // colore parte mancante
                    min: 0,
                    max: 2,
                    value: tts.value.pitch, 
                    onChanged: (value) => tts.value.setPitch(value),
                  ),
                )
              ],
            ),

            SizedBox(height: 40,), // un po' di distanza

          ],
        ),
      ),
    ), 
      backgroundColor: Colors.white,
    );
  }
}