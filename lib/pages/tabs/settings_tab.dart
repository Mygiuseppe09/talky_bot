import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:TalkyBot/models/tts.dart';
import 'package:TalkyBot/pages/license_attribution.dart';

import '../../components/my_slider.dart';

class SettingsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus(); // nascondiamo la tastiera
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (_) => LicenseAndAttribution())),
        backgroundColor: Colors.black,
        child: Icon(Icons.question_mark, color: Colors.white),
      ),
      body: Obx(
        () => // rendiamo il tutto "osservabile" per gestire i cambiamenti
            Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 5),

              SizedBox(
                // icona robottino
                width: 120,
                height: 120,
                child: Image.asset("images/bot.png"),
              ),

              SizedBox(height: 25), // un po' di distanza

              MySlider(
                // blocco volume
                icon: Icons.volume_down,
                title: "Volume",
                subtitle: "regola il volume del lettore artificale",
                min: 0,
                max: 1,
                value: tts.value.getVolume,
                onChanged: (value) => tts.value.setVolume(value),
                displayedValue: (tts.value.getVolume * 100).toStringAsFixed(0),
              ),

              MySlider(
                icon: Icons.speed,
                title: "Velocità",
                subtitle:
                    "regola la velocità durante la lettura dell'assistente",
                min: 0,
                max: 2,
                displayedValue: (tts.value.getRate * 50).toStringAsFixed(0),
                value: tts.value.getRate,
                onChanged: (value) => tts.value.setRate(value),
              ),

              MySlider(
                icon: Icons.mic,
                title: "Tono",
                subtitle:
                    "l'assistente è in grado di variare il suo tono, impostalo a tuo piacere",
                min: 0,
                max: 2,
                value: tts.value.getPitch,
                displayedValue: (tts.value.getPitch * 50).toStringAsFixed(0),
                onChanged: (value) => tts.value.setPitch(value),
              ),

              SizedBox(height: 60),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
