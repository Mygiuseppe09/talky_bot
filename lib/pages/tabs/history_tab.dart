import 'package:flutter/material.dart';
import 'package:to_speak/states/history_state.dart';


class HistoryBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: ListView.separated(
        padding: EdgeInsets.all(5),
        itemCount: historyState.value.searchHistoryList.length,
        itemBuilder: (_, index) => Card(
          elevation: 2,
          child: Container(
            padding: EdgeInsets.all(15),
            child: Text(historyState.value.searchHistoryList[index], style: TextStyle(
              fontSize: 18
            ),  
          ),
        ),
      ),
        separatorBuilder: (_,index) => SizedBox(height: 5,),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: (){},
        child: Icon(Icons.delete, color: Colors.white),
        ),
      );
  }
}
