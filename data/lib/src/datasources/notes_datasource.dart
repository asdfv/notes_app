import 'package:data/src/models/remote_note.dart';

abstract class NotesDatasource {
  Future<RemoteNote> getNote(String id);

  Future<List<RemoteNote>> getNotes();

  Future<RemoteNote> save(RemoteNote note);

  Future<void> delete(String id);
}
