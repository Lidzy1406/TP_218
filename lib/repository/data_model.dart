// data_model.dart
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  String name = '';
  String description = '';

  // String get _name => name;
  //String get _description => description;

  void setName(String newName) {
    name = newName;
    // notifyListenersWith('_name');
    notifyListeners();
  }

  void setDescription(String newDescription) {
    description = newDescription;
    //notifyListenersWith('_description');
    notifyListeners();
  }

  /*void notifyListenersWith(String fieldName) {
    for (var listener in listeners) {
      if (listener.listeningFor == fieldName) {
        listener.callback();
      }
    }
  }

  List<_Listener> listeners = [];

  void addListener(void Function() callback, {String? listeningFor}) {
    listeners
        .add(_Listener(callback: callback, listeningFor: listeningFor = ''));
  }

  void removeListener(void Function() callback) {
    listeners.removeWhere((listener) => listener.callback == callback);
  }
}

class _Listener {
  final void Function() callback;
  final String listeningFor;

  _Listener({required this.callback, required this.listeningFor});*/
}
