import 'package:TalkyBot/components/my_card.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:TalkyBot/models/chronology.dart';
import 'package:lottie/lottie.dart';

class ChronologyBody extends StatefulWidget {
  const ChronologyBody({Key? key}) : super(key: key);
  
  @override
  State<ChronologyBody> createState() => _ChronologyBodyState();
}


class _ChronologyBodyState extends State<ChronologyBody> {

   void copyOnClipboard(BuildContext context, int index) 
    => FlutterClipboard.copy(chronology.value.getChronologyList.elementAt(index))
          .then((_) =>
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                '''"${chronology.value.getChronologyList.elementAt(index)}" è stato copiato negli appunti''',
                textAlign: TextAlign.center,
              ))));
                

  @override
  Widget build(BuildContext context) {
    FocusManager.instance.primaryFocus?.unfocus(); // nascondiamo la tastiera
    if (chronology.value.getChronologyList.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                "animated/empty.json",
              ),
              SizedBox(height: 30),
              Text(
                "Cronologia vuota",
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 90, 90, 90)
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // ci sono messaggi in cronologia
      return 
      Scaffold(
        backgroundColor: Colors.white,
        body: Obx(() => ListView.separated(
              padding: EdgeInsets.all(5),
              itemCount: chronology.value.getChronologyList.length,
              itemBuilder: (_, index) => GestureDetector(
                onTap: () => copyOnClipboard(context, index),
                child: MyCard(
                  child: Text(
                      chronology.value.getChronologyList.elementAt(index),
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
              ),
              separatorBuilder: (_,__) => SizedBox(height: 5)
                )
               ),

        /// PULSANTE CHE CANCELLA LO STORICO
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
