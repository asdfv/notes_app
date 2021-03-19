import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';

abstract class NotesState with EquatableMixin {}

class Loading extends NotesState {
  @override
  List<Object> get props => [];
}

class LoadingFailed extends NotesState {
  final Object cause;
  final String reason;

  LoadingFailed(this.cause, this.reason);

  @override
  List<Object> get props => [reason];
}

class DeletingFailed extends NotesState {
  final String reason;

  DeletingFailed(this.reason);

  @override
  List<Object> get props => [reason];
}

class NotesUpdated extends NotesState {
  final List<Note> notes;

  NotesUpdated(this.notes);

  @override
  List<Object> get props => [notes];
}
