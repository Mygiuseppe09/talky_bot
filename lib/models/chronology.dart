import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final chronology = Chronology().obs;

class Chronology {
  final List<String> _chronologyList = [];

  List<String> get getChronologyList => _chronologyList;

  void copy(String text) {
    _chronologyList.add(text);

    chronology.refresh();
  }

  void addNew(String newText) {
    _chronologyList.insert(0, newText);

    chronology.refresh();
  }

  void clear() {
    GetStorage().erase(); // cancelliamo lo storage locale
    _chronologyList.clear();

    chronology.refresh();
  }
}
