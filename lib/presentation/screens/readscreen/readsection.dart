import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_pjt/presentation/screens/detailsscreen/detailsscreen.dart';
import 'package:hive_pjt/presentation/screens/homescreen/homepage.dart';
import 'package:hive_pjt/presentation/screens/readscreen/readscreenbloc/readscreen_bloc_bloc.dart';
import 'package:hive_pjt/presentation/screens/writescreen/writesection.dart';

final _myBox = Hive.box('mybox');

class ShowData extends StatelessWidget {
  String _searchQuery = '';

  List<Widget> _getData(BuildContext context) {
    List<Widget> tiles = [];
    for (int i = 0; i < _myBox.length; i += 5) {
      final name = _myBox.get(i) as String?;
      final age = _myBox.get(i + 1) as String?;
      final rollNumber = _myBox.get(i + 2) as String?;
      final classValue = _myBox.get(i + 3) as String?;
      final imagePath = _myBox.get(i + 4) as String?;

      if (_searchQuery.isNotEmpty &&
          !name!.toLowerCase().contains(_searchQuery.toLowerCase())) {
        continue; // skip the tile if the name doesn't match the search query
      }

      tiles.add(ListTile(
        title: Text('Name: $name'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Age: $age'),
            Text('Roll Number: $rollNumber'),
            Text('Class: $classValue'),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                BlocProvider.of<ReadscreenBlocBloc>(context).add(
                  EditLogic(
                    name: name!,
                    age: age!,
                    rollNumber: rollNumber!,
                    classValue: classValue!,
                    imagePath: imagePath,
                    index: i,
                  ),
                );
              },
              icon: const Icon(Icons.edit),
            ),
            IconButton(
              onPressed: () {
                BlocProvider.of<ReadscreenBlocBloc>(context)
                    .add(DeleteLogic(i: i, j: j));
              },
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
        leading: imagePath != null
            ? CircleAvatar(
                radius: 30,
                backgroundImage: FileImage(File(imagePath)),
              )
            : const Icon(Icons.person),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                name: name,
                age: age,
                rollNumber: rollNumber,
                classValue: classValue,
                imagePath: imagePath,
              ),
            ),
          );
        },
      ));
    }
    return tiles;
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReadscreenBlocBloc(context),
      child: BlocBuilder<ReadscreenBlocBloc, ReadscreenBlocState>(
        builder: (context, state) {
          if (state is SearchScreenstate) {
            _searchQuery = state.searchQuery;
          }

          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                icon: const Icon(Icons.arrow_back),
              ),
              title: TextField(
                onChanged: (value) {
                  _searchQuery = value;
                  BlocProvider.of<ReadscreenBlocBloc>(context).add(
                    SearchLogic(searchQuery: value),
                  );
                },
                decoration: InputDecoration(
                  hintText: 'Search...',
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            _searchQuery = '';
                            BlocProvider.of<ReadscreenBlocBloc>(context).add(
                              SearchLogic(searchQuery: ''),
                            );
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
              ),
            ),
            body: ValueListenableBuilder(
              valueListenable: _myBox.listenable(),
              builder: (context, Box box, _) {
                return ListView(
                  children: _getData(context),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
