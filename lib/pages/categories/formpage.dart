import 'package:flutter/material.dart';
import 'package:todoapp/repository/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormPage extends ConsumerWidget {
  const FormPage(
      {Key? key, required description, required name, required String docId})
      : super(key: key);
  
  @override
  
  Widget build(BuildContext context, WidgetRef ref) {
    
    final viewModel = ref.watch(viewProvider);
    final nameController =
        TextEditingController(text: viewModel.dataModel.name);
    final descriptionController =
        TextEditingController(text: viewModel.dataModel.description);

    return Scaffold(
      appBar: AppBar(
        title: Text('Formulaire'),
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
