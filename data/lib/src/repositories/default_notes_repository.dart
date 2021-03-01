import 'package:data/data_module.dart';
import 'package:domain/domain_module.dart';

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
  Future<Note> save(Note note) {
    return fireStoreDatasource.save(RemoteNote.fromNote(note)).then((remoteNote) => remoteNote.toNote());
  }

  @override
  Future<void> delete(String id) async {
    return fireStoreDatasource.delete(id);
  }
}
