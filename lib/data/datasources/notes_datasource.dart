import 'package:notes_app/data/models/remote_note.dart';

abstract class NotesDatasource {
  Future<RemoteNote> getNote(String id);
  Future<List<RemoteNote>> getNotes();
  Future<String> save(RemoteNote note);
  Future<void> delete(String id);
}
