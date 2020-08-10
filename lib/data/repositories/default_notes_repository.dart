import 'package:notes_app/data/datasources/notes_datasource.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';

class DefaultNotesRepository extends NotesRepository {
  final NotesDatasource notesDatasource;

  DefaultNotesRepository(this.notesDatasource);

  @override
  Future<Note> getNote(String id) =>
      notesDatasource.getNote(id).then((remoteNote) => remoteNote.toNote());

  @override
  Future<List<Note>> getNotes() async {
    var remoteNotes = await notesDatasource.getNotes();
    List<Note> iterable = remoteNotes.map((remoteNote) => remoteNote.toNote()).toList();
    return Future<List<Note>>.value(iterable);
  }
}
