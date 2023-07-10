import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_pjt/presentation/screens/editscreen/editpage.dart';

part 'readscreen_bloc_event.dart';
part 'readscreen_bloc_state.dart';

final _myBox = Hive.box('mybox');

class ReadscreenBlocBloc
    extends Bloc<ReadscreenBlocEvent, ReadscreenBlocState> {
  final BuildContext context;

  ReadscreenBlocBloc(this.context) : super(ReadscreenBlocInitial()) {
    on<EditLogic>((event, emit) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditScreen(
                  index: event.index,
                  name: 'name',
                  age: 'age',
                  classValue: 'classValue',
                  rollNumber: 'rollNumber',
                  imagePath: 'imagePath',
                )),
      );
    });

    on<DeleteLogic>((event, emit) {
      _myBox.deleteAt(event.i + 4);
      _myBox.deleteAt(event.i + 3);
      _myBox.deleteAt(event.i + 2);
      _myBox.deleteAt(event.i + 1);
      _myBox.deleteAt(event.i);
      event.j = 0;
    });

    on<SearchLogic>((event, emit) {
      emit(SearchScreenstate(searchQuery: event.searchQuery));
    });
  }
}
