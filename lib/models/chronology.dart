import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final chronology = Chronology().obs;

class Chronology {
  List<String> chronologyList = [];

  void copy(String text) {
    chronologyList.add(text);

    chronology.refresh();
  }

  void addNew(String newText) {
    chronologyList.insert(0, newText);

    chronology.refresh();
  }

  void clear() {
    GetStorage().erase(); // cancelliamo lo storage locale
    chronologyList.clear();

    chronology.refresh();
  }
}
