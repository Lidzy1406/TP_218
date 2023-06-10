// view_model.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final dataProvider = ChangeNotifierProvider<DataModel>((ref) => DataModel());

class ViewModel extends ChangeNotifier {
  final DataModel dataModel;

  ViewModel(this.dataModel);
final _ref = FirebaseFirestore.instance.collection('catégorie');
  void saveData() async {
    // récupérez la référence de la collection Firebase
    // et ajoutez les données de modèle de données ici
    await _ref.add({
      'name': dataModel.name,
      'description': dataModel.description,
    });
    cancel();
  }

  void cancel() {
    dataModel.setName('');
    dataModel.setDescription('');
  }
}
final viewProvider = ChangeNotifierProvider<ViewModel>((ref) {
  final data = ref.watch(dataProvider); // Ici nous accédons à la valeur actuelle de notre DataModel
  return ViewModel(data); // nous retournons le ViewModel contenant notre DataModel
});
// view_model.dart



  
