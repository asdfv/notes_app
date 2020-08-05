import 'package:notes_app/data/datasources/notes_datasource.dart';
import 'package:notes_app/data/models/remote_note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreNotesDatasource extends NotesDatasource {
  final String collectionName = "notes";
  final Firestore _firestore;

  FirestoreNotesDatasource(this._firestore);

  @override
  Future<RemoteNote> getNote(String id) => Future.delayed(
        Duration(seconds: 1),
        () => RemoteNote("Tit", "Desc"),
      );

  @override
  Future<List<RemoteNote>> getNotes() async {
    final data = await _firestore.collection(collectionName).getDocuments();
    var notes = data.documents.map((snapshot) => RemoteNote.fromSnapshot(snapshot)).toList();
    return Future.value(notes);
  }
}
