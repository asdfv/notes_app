import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:domain/domain_module.dart';

class RemoteNote {
  String id;
  String title;
  String description;
  int created;

  RemoteNote({this.id, this.title, this.description, this.created}) {
    if (id == null) this.id = DateTime.now().millisecondsSinceEpoch.toString();
  }

  RemoteNote.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot.id ?? '-';
    this.title = snapshot['title'] ?? '-';
    this.description = snapshot['description'] ?? '-';
    this.created = snapshot['created'] ?? 0;
  }

  RemoteNote.fromNote(Note note) {
    this.id = note.id;
    this.title = note.title;
    this.description = note.description;
    this.created = note.created;
  }

  Note toNote() => Note(id: id, title: title, description: description, created: created);
}
