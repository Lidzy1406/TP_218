import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/repository/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormPage extends ConsumerWidget {
  const FormPage(/*DocumentReference<Map<String, dynamic>> doc, */
      {
    Key? key,
    required this.docId,
    required this.name,
    required this.description,
  }) : super(key: key);

  final String docId;
  final String name;
  final String description;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(viewProvider);
    final _formKey = GlobalKey<FormState>();

    final nameController =
        TextEditingController(text: viewModel.dataModel.name);
    final descriptionController =
        TextEditingController(text: viewModel.dataModel.description);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire Categorie'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remplissez le formulaire ci-dessous:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    //  controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                    ),
                    onChanged: viewModel.dataModel.setName,
                  ),
                  TextField(
                    //controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                    ),
                    onChanged: viewModel.dataModel.setDescription,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.saveData,
                        child: Text('Enregistrer'),
                      ),
                      ElevatedButton(
                        onPressed: viewModel.cancel,
                        child: Text('Annuler'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
