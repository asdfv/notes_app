import 'package:data/datasources/notes_datasource.dart';
import 'package:data/models/remote_note.dart';
import 'package:domain/models/note.dart';
import 'package:domain/repositories/notes_repository.dart';

class DefaultNotesRepository extends NotesRepository {
  final NotesDatasource fakeDatasource;
  final NotesDatasource fireStoreDatasource;

  DefaultNotesRepository(this.fakeDatasource, this.fireStoreDatasource);

  @override
  Future<Note> getNote(String id) {
    return fireStoreDatasource.getNote(id).then((remoteNote) => remoteNote.toNote());
  }

  @override
  Future<List<Note>> getNotes() async {
    List<RemoteNote> remoteNotes;
    remoteNotes = await fireStoreDatasource.getNotes();
    List<Note> iterable = remoteNotes.map((remoteNote) => remoteNote.toNote()).toList();
    return Future<List<Note>>.value(iterable);
  }

  @override
  Future<String> save(Note note) {
    return fireStoreDatasource.save(RemoteNote.fromNote(note));
  }

  @override
  Future<void> delete(String id) async {
    return fireStoreDatasource.delete(id);
  }
}
