part of 'writescreen_bloc_bloc.dart';

abstract class WritescreenBlocState {}

class WritescreenBlocInitial extends WritescreenBlocState {}

class WritescreenBlocImageSelected extends WritescreenBlocState {
  final String imagePath;

  WritescreenBlocImageSelected({required this.imagePath});
}

class WritescreenBlocError extends WritescreenBlocState {
  final String errorMessage;

  WritescreenBlocError({required this.errorMessage});
}




