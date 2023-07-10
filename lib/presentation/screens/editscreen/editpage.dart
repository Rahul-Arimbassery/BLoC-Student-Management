import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'editscreenbloc/editscreenbloc_bloc.dart';

class EditScreen extends StatefulWidget {
  final int index;

  EditScreen({
    Key? key,
    required this.index,
    required String name,
    required String age,
    required String rollNumber,
    required String classValue,
    String? imagePath,
  }) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _rollNumberController = TextEditingController();
  final _classController = TextEditingController();
  ValueNotifier<String?> _imagePathNotifier = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    final _myBox = Hive.box('mybox');

    // Load the student details into the form fields
    _nameController.text = _myBox.get(widget.index) as String? ?? '';
    _ageController.text = _myBox.get(widget.index + 1) as String? ?? '';
    _rollNumberController.text = _myBox.get(widget.index + 2) as String? ?? '';
    _classController.text = _myBox.get(widget.index + 3) as String? ?? '';
    _imagePathNotifier.value = _myBox.get(widget.index + 4) as String?;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _rollNumberController.dispose();
    _classController.dispose();
    _imagePathNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditscreenblocBloc(),
      child: BlocBuilder<EditscreenblocBloc, EditscreenblocState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Edit Student'),
            ),
            body: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _ageController,
                        decoration: const InputDecoration(
                          labelText: 'Age',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an age';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _rollNumberController,
                        decoration: const InputDecoration(
                          labelText: 'Roll Number',
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a roll number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: _classController,
                        decoration: const InputDecoration(
                          labelText: 'Class',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a class';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      ValueListenableBuilder<String?>(
                        valueListenable: _imagePathNotifier,
                        builder: (context, imagePath, _) {
                          return imagePath != null
                              ? Image.file(
                                  File(imagePath),
                                  height: 200,
                                )
                              : const SizedBox(height: 0);
                        },
                      ),
                      const SizedBox(height: 8),
                      TextButton.icon(
                        onPressed: () async {
                          final imagePicker = ImagePicker();
                          final pickedImage = await imagePicker.pickImage(
                            source: ImageSource.gallery,
                          );

                          if (pickedImage != null) {
                            _imagePathNotifier.value = pickedImage.path;
                          }
                        },
                        icon: const Icon(Icons.photo),
                        label: const Text('Choose Image'),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            String passname = _nameController.text;
                            String passage = _ageController.text;
                            String passrollNumber = _rollNumberController.text;
                            String passclassname = _classController.text;
                            String? passimagepath = _imagePathNotifier.value;

                            BlocProvider.of<EditscreenblocBloc>(context).add(
                              SaveEvent(
                                age: passage,
                                classname: passclassname,
                                imagepath: passimagepath,
                                index: widget.index,
                                name: passname,
                                rollNumber: passrollNumber,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
