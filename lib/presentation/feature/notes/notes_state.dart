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

class NotesReceived extends NotesState {
  final List<Note> notes;

  NotesReceived(this.notes);
}

class NoteDeleted extends NotesState {
  final String id;

  NoteDeleted(this.id);
}
