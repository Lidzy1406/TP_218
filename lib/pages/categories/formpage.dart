import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/repository/view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormPage extends ConsumerWidget {
  const FormPage(
      {Key? key,
      required this.docId,
      required this.name,
      required this.description})
      : super(key: key);

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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Remplissez le formulaire ci-dessous:',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Add border radius
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
                  SizedBox(height: 10), // Add space between fields
                  TextField(
                    //  controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Nom',
                      labelStyle: TextStyle(color: Colors.black), // Set text color
                    ),
                    onChanged: viewModel.dataModel.setName,
                    style: TextStyle(
                      color: Colors.black, // Set text color
                    ),
                  ),
                  SizedBox(height: 10), // Add space between fields
                  TextField(
                    //controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: TextStyle(color: Colors.black), // Set text color
                    ),
                    onChanged: viewModel.dataModel.setDescription,
                    style: TextStyle(
                      color: Colors.black, // Set text color
                    ),
                  ),
                  SizedBox(height: 16), // Add space before buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: viewModel.saveData,
                        child: Text('Enregistrer'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Set button color
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Add border radius
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: viewModel.cancel,
                        child: Text('Annuler'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.orange), // Set button color
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10), // Add border radius
                            ),
                          ),
                        ),
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