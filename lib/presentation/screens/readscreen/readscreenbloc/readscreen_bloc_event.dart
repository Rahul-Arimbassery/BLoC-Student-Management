part of 'readscreen_bloc_bloc.dart';

class ReadscreenBlocEvent {}

class EditLogic extends ReadscreenBlocEvent {
  final String name;
  final String age;
  final String rollNumber;
  final String classValue;
  final String? imagePath;
  final int index;

  EditLogic(
      {required this.name,
      required this.age,
      required this.rollNumber,
      required this.classValue,
      required this.imagePath,
      required this.index});
}

class DeleteLogic extends ReadscreenBlocEvent {
  final int i;
  int j;

  DeleteLogic({required this.i, required this.j});
}

class SearchLogic extends ReadscreenBlocEvent {
  final String searchQuery;

  SearchLogic({required this.searchQuery});
}
