import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todoapp/pages/Todo/ui/items/providers/write_item_view_model_provider.dart';

import '../components/loading_layer.dart';
import '../components/snackbar.dart';

class WriteItemPage extends ConsumerWidget {
  WriteItemPage({Key? key}) : super(key: key);
  static const String route = "/writeItem";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme;
    final scheme = theme.colorScheme;
    final provider = writeItemViewModelProvider;
    final model = ref.read(writeItemViewModelProvider);
    return LoadingLayer(
      child: Scaffold(
        appBar: AppBar(
          title: Text("${model.edit ? "Edit" : "Add"} Item"),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
          child: Consumer(builder: (context, ref, child) {
            ref.watch(provider);
            return MaterialButton(
              padding: const EdgeInsets.all(16),
              color: scheme.primary,
              onPressed: model.enabled
                  ? () async {
                      try {
                        await model.write();
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                      } catch (e) {
                        AppSnackbar(context).error(e);
                      }
                    }
                  : null,
              child: const Text("DONE"),
            );
          }),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  final picked = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    model.file = File(picked.path);
                  }
                },
                child: Consumer(builder: (context, ref, child) {
                  ref.watch(provider.select((value) => value.file));
                  return Container(
                    height: 200,
                    width: 200,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: scheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                        image: (model.image != null || model.file != null)
                            ? DecorationImage(
                                image: model.file != null
                                    ? FileImage(model.file!)
                                    : NetworkImage(model.image!)
                                        as ImageProvider,
                                fit: BoxFit.cover,
                              )
                            : null),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (model.image == null && model.file == null)
                          Expanded(
                            child: Center(
                              child: Icon(
                                Icons.photo,
                                color: scheme.onPrimaryContainer,
                              ),
                            ),
                          ),
                        Material(
                          color: theme.cardColor.withOpacity(0.5),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Pick Image".toUpperCase(),
                              style: style.bodySmall,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              TextFormField(
                initialValue: model.title,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: "Title",
                ),
                onChanged: (v) => model.title = v,
              ),
              // const SizedBox(height: 24),
              // TextFormField(
              //   maxLines: 10,
              //   minLines: 5,
              //   textInputAction: TextInputAction.done,
              //   initialValue: model.description,
              //   textCapitalization: TextCapitalization.sentences,
              //   decoration: const InputDecoration(
              //     labelText: "Description",
              //   ),
              //   onChanged: (v) => model.description = v,
              // ),
              const SizedBox(height: 24),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Start Time",
                        suffixIcon: Icon(
                          Icons.calendar_today_rounded,
                        ),
                      ),
                      onTap: () async {
                        final TimeOfDay? selectedTime =
                            await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          model.starttime = selectedTime.format(context);
                        }
                      },
                      readOnly: true,
                      initialValue: model.starttime,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "End Time",                        
                        suffixIcon: Icon(
                          Icons.calendar_today_rounded,
                        ),
                      ),
                      onTap: () async {
                        final TimeOfDay? selectedTime =
                            await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (selectedTime != null) {
                          model.endtime = selectedTime.format(context);
                        }
                      },
                      readOnly: true,
                      initialValue: model.endtime,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
                  //   DropdownButtonFormField<String>(
                  //   value: model.categories,
                  //   onChanged: (value) {
                  //     model.categories = value!;
                  //   },
                  //   items: categories.map((String category) {
                  //     return DropdownMenuItem<String>(
                  //       value: category,
                  //       child: Text(category),
                  //     );
                  //   }).toList(),
                  //   decoration: const InputDecoration(
                  //     labelText: "Categories",
                  //   ),
                  // ),
                Text(
                "Category",
                style:
                    style.labelLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 8),
StreamBuilder<QuerySnapshot>(
  stream: FirebaseFirestore.instance.collection('catégorie').snapshots(),
  builder: (context, snapshot) {
    if (!snapshot.hasData) {
      return const Text('Chargement...');
    }
    final documents = snapshot.data!.docs;
    final items = <DropdownMenuItem<String>>[];
    for (final doc in documents) {
      final data = doc.data() as Map<String, dynamic>;
      if (data.containsKey('name')) {
        final name = data['name'] as String;
        items.add(DropdownMenuItem<String>(
          value: name,
          child: Text(name),
        ));
      }
    }
    final selectedName = model.categories ?? '';
    final isValid = items.map((item) => item.value).contains(selectedName);
    return DropdownButtonFormField<String>(
      value: isValid ? selectedName : null,
      onChanged: (value) {
        model.categories = value!;
      },
      items: items,
      decoration: InputDecoration(
        labelText: 'Catégorie',
        border: OutlineInputBorder(),
      ),
    );
  },
),





            ],
          ),
        ),
      ),
    );
  }
}