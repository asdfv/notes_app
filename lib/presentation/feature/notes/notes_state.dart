import 'package:notes_app/domain/models/note.dart';

abstract class NotesState {

}

class LoadingState extends NotesState {}

class LoadingFailedState extends NotesState {
  final Object cause;
  final String reason;

  LoadingFailedState(this.cause, this.reason);
}

class DeletingFailedState extends NotesState {
  final Object cause;
  final String reason;
  final List<Note> notes;

  DeletingFailedState(this.cause, this.reason, this.notes);
}

class NotesReceivedState extends NotesState {
  final List<Note> notes;

  NotesReceivedState(this.notes);
}

class NoteDeletedState extends NotesState {
  final String id;
  final List<Note> notes;

  NoteDeletedState(this.id, this.notes);
}
