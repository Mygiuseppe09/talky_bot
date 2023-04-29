import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:to_speak/models/chronology.dart';

class ChronologyBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Obx(() => ListView.separated(
        padding: EdgeInsets.all(5),
        itemCount: chronology.value.chronologyList.length,
        itemBuilder: (_, index) => GestureDetector(
          onTap: () => log("tappato il messaggio: ${chronology.value.chronologyList[index]}"),
          child: Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text(
                chronology.value.chronologyList[index],
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
        separatorBuilder: (_, index) => SizedBox(
          height: 5,
        ),
      )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => chronology.value.clear(),
        backgroundColor: Colors.black,
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }
}
