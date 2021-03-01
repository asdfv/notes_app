import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/models/remote_note.dart';
import 'package:domain/domain_module.dart';

import 'notes_datasource.dart';

class FirestoreNotesDatasource extends NotesDatasource {
  final String _collectionName = "notes";
  final FirebaseFirestore _firestore;
  final log = getLogger();

  FirestoreNotesDatasource(this._firestore);

  @override
  Future<RemoteNote> getNote(String id) async {
    var snapshot = await _firestore.collection(_collectionName).doc(id).get();
    if (snapshot.data != null) {
      return Future.value(RemoteNote.fromSnapshot(snapshot));
    }
    throw Exception("Document with id = $id not found.");
  }

  @override
  Future<List<RemoteNote>> getNotes() async {
    final data = await _firestore.collection(_collectionName).orderBy('created', descending: true).get();
    var notes = data.docs.map((snapshot) => RemoteNote.fromSnapshot(snapshot)).toList();
    return Future.value(notes);
  }

  @override
  Future<RemoteNote> save(RemoteNote note) async {
    var document = await _firestore.collection(_collectionName).add({
      'title': note.title,
      'description': note.description,
      'created': note.created ?? DateTime.now().millisecondsSinceEpoch,
    });
    note.id = document.id;
    return note;
  }

  @override
  Future<void> delete(String id) {
    log.d(message: "Deleting note: $id");
    return _firestore.collection(_collectionName).doc(id).delete();
  }
}
