import 'package:domain/models/note.dart';

abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class OpenDetails extends NotesEvent {
  final String id;

  OpenDetails(this.id);
}

class DeleteNote extends NotesEvent {
  final String id;
  final List<Note> notes;
  final int index;

  DeleteNote(this.id, this.notes, this.index);
}
