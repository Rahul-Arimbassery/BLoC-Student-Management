import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'writescreen_bloc_event.dart';
part 'writescreen_bloc_state.dart';


class WritescreenBlocBloc
    extends Bloc<WritescreenBlocEvent, WritescreenBlocState> {
  WritescreenBlocBloc() : super(WritescreenBlocInitial()) {
    on<SelectImageEvent>((event, emit) {
      emit(WritescreenBlocImageSelected(imagePath: event.image!.path));
    });

    on<SaveDBEvent>((event, emit) {
      emit(WritescreenBlocError(errorMessage: event.errorMessage));
    });
  }
}



