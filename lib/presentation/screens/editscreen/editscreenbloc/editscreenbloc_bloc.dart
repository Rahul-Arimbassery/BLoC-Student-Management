import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'editscreenbloc_event.dart';
part 'editscreenbloc_state.dart';

class EditscreenblocBloc
    extends Bloc<EditscreenblocEvent, EditscreenblocState> {
  EditscreenblocBloc() : super(EditscreenblocInitial()) {
    on<SaveEvent>((event, emit) {
      final _myBox = Hive.box('mybox');
      _myBox.put(event.index, event.name);
      _myBox.put(event.index + 1, event.age);
      _myBox.put(event.index + 2, event.rollNumber);
      _myBox.put(event.index + 3, event.classname);
      _myBox.put(event.index + 4, event.imagepath);
    });
  }
}
