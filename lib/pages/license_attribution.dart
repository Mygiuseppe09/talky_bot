import 'package:flutter/material.dart';

import '../components/my_card.dart';
import '../components/my_title.dart';

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

        MyCard( // flutter
          child: Row(
            children: [
              Image.asset(
                "images/flutter.png",
                width: 110,
                ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyTitle(text: "Flutter"),
                    Text("Quest'app è stata realizzata attraverso Flutter: un framework open-source creato da Google per la creazione di interfacce native per iOS, Android, Linux, macOS e Windows", 
                      textAlign: TextAlign.center,)
                  ],
                ),
              )
            ],
          ),
        ),

        

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