import 'package:notes_app/data/datasources/notes_datasource.dart';
import 'package:notes_app/data/models/remote_note.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';

// todo, change fake/real datasource choosing way
class DefaultNotesRepository extends NotesRepository {
  final NotesDatasource fakeDatasource;
  final NotesDatasource fireStoreDatasource;

  DefaultNotesRepository(this.fakeDatasource, this.fireStoreDatasource);

  @override
  Future<Note> getNote(String id) {
    try {
      return fireStoreDatasource.getNote(id).then((remoteNote) => remoteNote.toNote());
    } catch (e) {
      print("Error getting note $id from Firestore, $e.");
      return fakeDatasource.getNote(id).then((remoteNote) => remoteNote.toNote());
    }
  }

  @override
  Future<List<Note>> getNotes() async {
    List<RemoteNote> remoteNotes;
    try {
      remoteNotes = await fireStoreDatasource.getNotes();
    } catch (e) {
      print("Error getting notes from Firestore, $e.");
      remoteNotes = await fakeDatasource.getNotes();
    }
    List<Note> iterable = remoteNotes.map((remoteNote) => remoteNote.toNote()).toList();
    return Future<List<Note>>.value(iterable);
  }

  @override
  Future<String> save(Note note) {
    try {
      return fireStoreDatasource.save(RemoteNote.fromNote(note));
    } catch (e) {
      print("Error saving into Firestore, $e.");
      return fakeDatasource.save(RemoteNote.fromNote(note));
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await fireStoreDatasource.delete(id);
    } catch (e) {
      print("Error deleting from Firestore, $e.");
      throw Exception("Error deleting from Firestore, $e.");
    }
  }
}
