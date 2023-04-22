import 'package:get/get.dart';

final historyState = HistoryState().obs;


class HistoryState {

  List<String> searchHistoryList= [];

  void addNew(String newText) {
    searchHistoryList.add(newText);
    historyState.refresh();
  }



}

