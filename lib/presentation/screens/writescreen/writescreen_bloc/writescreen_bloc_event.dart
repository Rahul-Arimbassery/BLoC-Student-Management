part of 'writescreen_bloc_bloc.dart';

abstract class WritescreenBlocEvent {}

class SelectImageEvent extends WritescreenBlocEvent {
  final File? image;
  SelectImageEvent(this.image);
}

class SaveDBEvent extends WritescreenBlocEvent {
  final String errorMessage;
  SaveDBEvent({required this.errorMessage});
}


