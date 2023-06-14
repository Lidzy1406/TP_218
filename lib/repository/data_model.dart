// data_model.dart
import 'package:flutter/foundation.dart';

class DataModel extends ChangeNotifier {
  String name = '';
  String description = '';

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setDescription(String newDescription) {
    description = newDescription;
    notifyListeners();
  }
}