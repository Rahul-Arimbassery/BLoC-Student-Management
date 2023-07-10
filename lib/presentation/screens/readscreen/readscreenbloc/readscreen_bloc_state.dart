part of 'readscreen_bloc_bloc.dart';

abstract class ReadscreenBlocState {}

class ReadscreenBlocInitial extends ReadscreenBlocState {}

class EditScreenstate extends ReadscreenBlocState {}

class DeleteScreenstate extends ReadscreenBlocState {}

class SearchScreenstate extends ReadscreenBlocState {
  final String searchQuery;

  SearchScreenstate({required this.searchQuery});
}
