import 'package:notes_app/domain/models/note.dart';

abstract class NotesRepository {
  Future<Note> getNote(String id);

  Future<List<Note>> getNotes();
}
