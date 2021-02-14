import 'package:domain/models/note.dart';

abstract class NotesRepository {
  Future<Note> getNote(String id);

  Future<List<Note>> getNotes();

  Future<Note> save(Note note);

  Future<void> delete(String id);
}
