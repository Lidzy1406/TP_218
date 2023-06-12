import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/repository/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormPage extends ConsumerWidget {
   const FormPage(/*DocumentReference<Map<String, dynamic>> doc, */
      {Key? key, required this.docId, required this.name, required this.description, }): super(key: key);

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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nom',
              ),
              onChanged: viewModel.dataModel.setName,
            ),
            TextField(
              controller: descriptionController,
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
    );
  }
  
}
