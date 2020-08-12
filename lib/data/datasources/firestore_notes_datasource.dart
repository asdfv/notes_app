import 'package:notes_app/data/datasources/notes_datasource.dart';
import 'package:notes_app/data/models/remote_note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreNotesDatasource extends NotesDatasource {
  final String _collectionName = "notes";
  final Firestore _firestore;

  FirestoreNotesDatasource(this._firestore);

  @override
  Future<RemoteNote> getNote(String id) => Future.delayed(
        Duration(seconds: 1),
        () => RemoteNote(title: "Title", description: "Desc", created: 13212313),
      );

  @override
  Future<List<RemoteNote>> getNotes() async {
    final data = await _firestore.collection(_collectionName).getDocuments();
    var notes = data.documents.map((snapshot) => RemoteNote.fromSnapshot(snapshot)).toList();
    return Future.value(notes);
  }

  @override
  Future<String> save(RemoteNote note) {
    return _firestore.collection(_collectionName).add({
      'title': note.title,
      'description': note.description,
      'created': note.created ?? DateTime.now().millisecondsSinceEpoch,
    }).then((document) => document.documentID);
  }
}
