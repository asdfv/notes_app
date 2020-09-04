import 'package:notes_app/domain/models/note.dart';

abstract class NotesEvent {}

class NotesAsked extends NotesEvent {}
class DetailsAsked extends NotesEvent {
  final String id;

  DetailsAsked(this.id);
}

class DeleteNoteAsked extends NotesEvent {
  final String id;
  final List<Note> notes;
  final int index;

  DeleteNoteAsked(this.id, this.notes, this.index);
}