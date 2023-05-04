import 'package:flutter/material.dart';

import '../components/my_list_tile.dart';

class LicenseAndAttribution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("license e attribuzioni"),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [

            MyListTile(
              imagePath: "images/flutter.png",
              title: "Flutter",
              description: "Quest'app è stata realizzata attraverso Flutter: un framework open-source creato da Google per la creazione di interfacce native per iOS, Android, Linux, macOS e Windows",
            ),

            MyListTile(
              imagePath: "images/flaticon.png",
              title: "Flaticon",
              description: "Molte delle icone utilizzate nell'app sono state recuperate su Flaticon.com, si ringraziano i seguenti autori: Freepik, kerismaker, Smashicons",
            ),

            MyListTile(
              imagePath: "images/text-to-speech.png",
              title: "Servizio text-to-speech",
              description: "Si ringrazia lo sviluppatore https://github.com/ixsans per aver creato e pubblicato la seguente libreria: https://pub.dev/packages/text_to_speech ",
            ),

            MyListTile(
              imagePath: "images/getx.png",
              title: "GetX",
              description: "Lo stato dei componenti e la cronologia dei testi sintetizzati sono stati gestiti attraverso questa libreria, consultabile al link: https://pub.dev/packages/get#about-get",
            )
            
          ],
        )
      ),
    );
  }
}

/**
 * Center(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  color: Colors.black,
                  height: 20,
                  width: 20,
                  child: Icon(Icons.code)),
                ListTile(
                  title: Text("Flutter"),
                  subtitle: Text("ooooo"),
                ),
              ],
            )
           
          ],
        ),
      )
 */