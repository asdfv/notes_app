import 'package:domain/models/note.dart';

abstract class NotesState {}

class Loading extends NotesState {}

class LoadingFailed extends NotesState {
  final Object cause;
  final String reason;

  LoadingFailed(this.cause, this.reason);
}

class DeletingFailed extends NotesState {
  final String reason;

  DeletingFailed(this.reason);
}

class NotesUpdated extends NotesState {
  final List<Note> notes;

  NotesUpdated(this.notes);
}
