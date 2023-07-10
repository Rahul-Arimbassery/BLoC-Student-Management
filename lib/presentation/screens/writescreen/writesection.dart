import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_pjt/presentation/screens/readscreen/readsection.dart';
import 'package:hive_pjt/presentation/screens/writescreen/writescreen_bloc/writescreen_bloc_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

int j = 0;

class WriteSection extends StatelessWidget {
  final _myBox = Hive.box('mybox');
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _rollNumberController = TextEditingController();
  final _classController = TextEditingController();
  final _imagePathNotifier = ValueNotifier<String?>(null);
  final picker = ImagePicker();
  String? _nameError;
  String? _ageError;
  String? _rollNumberError;
  String? _classError;

  void writeData(int key, dynamic value) {
    _myBox.put(key, value);
  }

  Future getImage(BuildContext context) async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _imagePathNotifier.value = pickedFile.path;

        // ignore: use_build_context_synchronously
        BlocProvider.of<WritescreenBlocBloc>(context).add(
          SelectImageEvent(File(pickedFile.path)),
        );
      }
    } catch (e) {
      // Handle error
    }
  }

  void validateAndSave(BuildContext context) {
    final name = _nameController.text;
    final age = _ageController.text;
    final rollNumber = _rollNumberController.text;
    final classValue = _classController.text;
    bool isValid = true;

    _nameError = name.isEmpty ? '*Field is mandatory' : null;
    _ageError = age.isEmpty ? '*Field is mandatory' : null;
    _rollNumberError = rollNumber.isEmpty ? '*Field is mandatory' : null;
    _classError = classValue.isEmpty ? '*Field is mandatory' : null;

    if (_imagePathNotifier.value == null) {
      isValid = false;
      Fluttertoast.showToast(
        msg: 'Image is required',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    if (_nameError != null) {
      BlocProvider.of<WritescreenBlocBloc>(context).add(
        SaveDBEvent(errorMessage: _nameError!),
      );
      isValid = false;
    }

    if (_ageError != null) {
      BlocProvider.of<WritescreenBlocBloc>(context).add(
        SaveDBEvent(errorMessage: _ageError!),
      );
      isValid = false;
    }

    if (_rollNumberError != null) {
      BlocProvider.of<WritescreenBlocBloc>(context).add(
        SaveDBEvent(errorMessage: _rollNumberError!),
      );
      isValid = false;
    }

    if (_classError != null) {
      BlocProvider.of<WritescreenBlocBloc>(context).add(
        SaveDBEvent(errorMessage: _classError!),
      );
      isValid = false;
    }

    if (isValid) {
      int i = j;
      writeData(i, name);
      writeData(i + 1, age);
      writeData(i + 2, rollNumber);
      writeData(i + 3, classValue);
      writeData(i + 4, _imagePathNotifier.value);
      _nameController.clear();
      _ageController.clear();
      _rollNumberController.clear();
      _classController.clear();
      _imagePathNotifier.value = null;
      j += 5;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ShowData()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WritescreenBlocBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Database Entry'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: BlocBuilder<WritescreenBlocBloc, WritescreenBlocState>(
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ValueListenableBuilder<String?>(
                        valueListenable: _imagePathNotifier,
                        builder: (context, imagePath, _) {
                          return Container(
                            alignment: Alignment.center,
                            child: imagePath != null
                                ? Image.file(File(imagePath))
                                : ElevatedButton(
                                    onPressed: () {
                                      getImage(context);
                                    },
                                    child: const Text('Select Image'),
                                  ),
                          );
                        },
                      ),
                      TextField(
                        style: const TextStyle(height: 0.1),
                        controller: _nameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Name',
                          errorText: (state is WritescreenBlocError &&
                                  _nameError != null)
                              ? state.errorMessage
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(height: 0.1),
                        controller: _ageController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Age',
                          errorText: (state is WritescreenBlocError &&
                                  _ageError != null)
                              ? state.errorMessage
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(height: 0.1),
                        controller: _rollNumberController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Roll Number',
                          errorText: (state is WritescreenBlocError &&
                                  _rollNumberError != null)
                              ? state.errorMessage
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        style: const TextStyle(height: 0.1),
                        controller: _classController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          hintText: 'Enter Class',
                          errorText: (state is WritescreenBlocError &&
                                  _classError != null)
                              ? state.errorMessage
                              : null,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () => validateAndSave(context),
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

