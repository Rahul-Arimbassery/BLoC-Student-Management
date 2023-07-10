import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_pjt/presentation/screens/readscreen/readsection.dart';
import 'package:hive_pjt/presentation/screens/writescreen/writesection.dart';

part 'homescreen_bloc_event.dart';
part 'homescreen_bloc_state.dart';

class HomescreenBlocBloc
    extends Bloc<HomescreenBlocEvent, HomescreenBlocState> {
  final BuildContext context;

  HomescreenBlocBloc({required this.context}) : super(HomescreenBlocInitial()) {
    on<Write>((event, emit) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  WriteSection()),
      );
    });

    on<Read>((event, emit) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  ShowData()),
      );
    });
  }
}
