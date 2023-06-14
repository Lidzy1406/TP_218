import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/repository/category_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/categorie.dart';
import 'EditPage.dart';
import 'formpage.dart';
/*
/*final addCategorieProvider =
   // ChangeNotifierProvider((ref) => AddCategories(ref.read));
ChangeNotifierProvider((ref) => AddCategories(ref.read,/*ref.watch as Reader*/));*/
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

//Création d'un Provider pour l'ajout de données
final addCategorieProvider =
    ChangeNotifierProvider<AddCategories>((ref) => AddCategories(ref.read));

class AddCategories extends ChangeNotifier {
  final Reader _read;
  //final Reader watch;
  AddCategories(
    this._read,
    // this.watch
  );

  Category _category = Category(name: '', description: '');
  //const AddCategories({Key? key}) : super(key: key);


  //Modifie le nom
  void updateNom(String name) {
    _category.name = name;
    notifyListeners();
  }

  //Modifie le prénom
  void updatePrenom(String description) {
    _category.description = description;
    notifyListeners();
  }
 // final _formKey = GlobalKey<FormState>();
  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();*/
//var _category = Category();
//var _categoryService = CategoryService();

/* void onSave() async {
    final messageData = Category(
      name: _categoryNameController.text,
      description: _categoryDescriptionController.text,
    );

    addData(messageData);

    _categoryNameController.clear();
    _categoryDescriptionController.clear();

    _formKey.currentState!.reset();
  }*/

/*Future<void> addData(Category _category) async {
    try {
      //Récupération de la référence Firebase
      final firestore = _read(firestoreProvider);

      //Ajout des données
      await firestore.collection('categorie').add(_category.toMap());
    } catch (e) {
      //Affichage d'une erreur si l'ajout a échoué
      print(e.toString());
    }
  }
}*/

/*Future<void> _saveData(Category category) async {
    try {
      final FirebaseFirestore firestore = read(firebaseFirestoreProvider);
      await firestore.collection('categorie').add({
        'name': category.name,
        'description': category.description,
      });
    } catch (e) {
      print('Error adding data: $e');
    }
  }*/

/*abstract class FormView extends StatelessWidget {
  const FormView({required Key key}) : super(key: key);

  @override
  _showFormDialog(BuildContext context) {
    return showDialog(
        /*context: context,
        barrierDismissible: true,*/
       builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () async {
                await context.read(addCategorieProvider).addData();

                },
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ],
            title: Text('Formulaire de Catégorie'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    //controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'nom de la catégorie', labelText: 'Category'),
                         onChanged: (value) => context.read(addCategorieProvider).updateNom(value),
                  ),
                  TextField(
                   // controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'description de la catégorie',
                        labelText: 'Description'),
                         onChanged: (value) => context.read(addCategorieProvider).updatePrenom(value),
                  ),
                ],
              ),
            ),
          );
        }
        );
  }
}*/
/*
class FormView extends StatelessWidget {
  const FormView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Champ de texte pour le nom
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
              onChanged: (value) => context.read(formDataProvider).updateNom(value),
            ),
            //Champ de texte pour le prénom
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Prénom',
              ),
              onChanged: (value) => context.read(formDataProvider).updatePrenom(value),
               ),
            //Bouton d'ajout des données
            ElevatedButton(
              onPressed: () async {
                //Ajout des données dans Firebase
                await context.read(formDataProvider).addData();

                //Affichage de la vue de confirmation
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConfirmationView(),
                  ),
                );
              },
              child: Text('Entrer'),
            )
          ],
        ),
      ),
    );
  }
}


*/

/*

 @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Ajouter une categories"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
*/
/*
@override
  _showFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                if (_formKey.currentState!.validate()) {
                    onSave();
                  }
                },
                child: Text('Save'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ],
            title: Text('Formulaire de Catégorie'),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                        hintText: 'nom de la catégorie', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _categoryDescriptionController,
                    decoration: InputDecoration(
                        hintText: 'description de la catégorie',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }
*/

//class AddCategorie extends StatelessWidget {
//const AddCategorie({Key? key}) : super(key: key);
/*
class ListPage extends ConsumerWidget {
   ListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(dataStream);

    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: data,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              final name = document.get('name');
              final description = document.get('description');
              return ListTile(
                title: Text(name),
                subtitle: Text(description),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }

  final dataStream = streamProvider<QuerySnapshot>((ref) => FirebaseFirestore
      .instance
      .collection('catégorie')
      .orderBy('name', descending: true)
      .snapshots());

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catégories'),
      ),
      body: Center(
        child: Text('Welcome to my app!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => FormPage()));
        },
        child: Icon(Icons.add),
      ),
    );
  }*/
}*/

final nameProvider = StateProvider<String>((ref) => '');
final descriptionProvider = StateProvider<String>((ref) => '');

class ListPage extends ConsumerWidget {
  const ListPage({Key? key}) : super(key: key);
  void _navigateToEdit(BuildContext context, String docId, String name,
      String description) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditPage(
                docId: docId,
                name: name,
                description: description,
              )),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<QuerySnapshot> data = ref.watch(dataStream);

    return Scaffold(
      appBar: AppBar(
        title: Text('Catégorie'),
      ),
      body: data.when(
        data: (QuerySnapshot querySnapshot) {
          final documents = querySnapshot.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final document = documents[index];
              final name = document.get('name');
              final description = document.get('description');
              final docId = document.id;
              return ListTile(
                title: Text(name),
                //subtitle: Text(description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        _navigateToEdit(context, docId, name, description);
                        // Effectuer une action lorsque l'utilisateur appuie sur le bouton de modification
                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                 FormPage( docId:docId, name:name, description:description)),
                      
                        );*/
                      },
                      icon: const Icon(Icons.edit),
                      color: Color.fromARGB(255, 244, 209, 54),
                    ),
                    IconButton(
                      onPressed: () {
                        // Effectuer une action lorsque l'utilisateur appuie sur le bouton de suppression
                        FirebaseFirestore.instance
                            .collection('catégorie')
                            .doc(docId)
                            .delete();
                      },
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => const Text('Something went wrong'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => FormPage(
                        docId: '',
                        name: '',
                        description: '',
                      )));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

final dataStream = StreamProvider<QuerySnapshot>((ref) => FirebaseFirestore
    .instance
    .collection('catégorie')
    .orderBy('name', descending: true)
    .snapshots());