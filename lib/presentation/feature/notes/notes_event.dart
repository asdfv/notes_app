import 'package:domain/models/note.dart';

abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class OpenDetails extends NotesEvent {
  final String id;

  OpenDetails(this.id);
}

class DeleteNote extends NotesEvent {
  final String id;

  DeleteNote(this.id);
}

class NoteAdded extends NotesEvent {
  final Note note;

  NoteAdded(this.note);
}

class NoteDeleted extends NotesEvent {
  final String id;

  NoteDeleted(this.id);
}
