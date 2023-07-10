part of 'editscreenbloc_bloc.dart';

class EditscreenblocEvent {}

class SaveEvent extends EditscreenblocEvent {
  final int index;
  final String name;
  final String age;
  final String rollNumber;
  final String classname;
  final String? imagepath;

  SaveEvent(
      {required this.index,
      required this.name,
      required this.age,
      required this.rollNumber,
      required this.classname,
      required this.imagepath});
}
