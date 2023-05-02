import 'package:ToSpeak/components/my_card.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:ToSpeak/models/chronology.dart';

class ChronologyBody extends StatefulWidget {
  @override
  State<ChronologyBody> createState() => _ChronologyBodyState();
}

class _ChronologyBodyState extends State<ChronologyBody> {
  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus(); // nascondiamo la tastiera
    if (chronology.value.chronologyList.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/empty.png",
                color: Colors.black54,
                scale: 3,
              ),
              SizedBox(height: 30),
              Text(
                "Cronologia vuota",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      );
    } else {
      // ci sono messaggi in cronologia
      return Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => ListView.separated(
              padding: EdgeInsets.all(5),
              itemCount: chronology.value.chronologyList.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () {
                  FlutterClipboard.copy(chronology.value.chronologyList.elementAt(index))
                      .then((_) =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                            '''"${chronology.value.chronologyList.elementAt(index)}" è stato copiato negli appunti''',
                            textAlign: TextAlign.center,
                          ))));
                },
                child: MyCard(
                  child: Text(
                      chronology.value.chronologyList.elementAt(index),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              ),
              separatorBuilder: (_, index) => SizedBox(height: 5),
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            chronology.value.clear();
            setState(() {}); // richiama il metodo build()
          },
          backgroundColor: Colors.black,
          child: Icon(Icons.delete, color: Colors.white),
        ),
      );
    }
  }
}
