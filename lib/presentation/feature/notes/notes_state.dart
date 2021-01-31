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
  final List<Note> notes;

  DeletingFailed(this.reason, this.notes);
}

class NotesReceived extends NotesState {
  final List<Note> notes;

  NotesReceived(this.notes);
}

class NoteDeleted extends NotesState {
  final String id;
  final List<Note> notes;

  NoteDeleted(this.id, this.notes);
}
