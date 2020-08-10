import 'package:notes_app/domain/models/note.dart';

abstract class NotesState {}

class Initial extends NotesState {}

class Loading extends NotesState {}

class Failed extends NotesState {
  final Exception cause;
  final String reason;

  Failed(this.cause, this.reason);
}

class NotesReceived extends NotesState {
  final List<Note> notes;

  NotesReceived(this.notes);
}