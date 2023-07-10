import 'dart:io';
import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String? name;
  final String? age;
  final String? rollNumber;
  final String? classValue;
  final String? imagePath;

  const DetailScreen({
    Key? key,
    this.name,
    this.age,
    this.rollNumber,
    this.classValue,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(11),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagePath != null
                ? Center(
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: FileImage(File(imagePath!)),
                    ),
                  )
                : const Icon(Icons.person, size: 80),
            const SizedBox(height: 16),
            Text('Name: ${name ?? ""}',
                style: Theme.of(context).textTheme. titleLarge),
            const SizedBox(height: 8),
            Text('Age: ${age ?? ""}',
                style: Theme.of(context).textTheme. titleLarge),
            const SizedBox(height: 8),
            Text('Roll Number: ${rollNumber ?? ""}',
                style: Theme.of(context).textTheme. titleLarge),
            const SizedBox(height: 8),
            Text('Class: ${classValue ?? ""}',
                style: Theme.of(context).textTheme. titleLarge),
          ],
        ),
      ),
    );
  }
}
