import 'package:notes_app/domain/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteNote {
  int id;
  String title;
  String description;
  int created;

  RemoteNote({this.id, this.title, this.description, this.created}) {
    if (id == null) this.id = DateTime.now().millisecondsSinceEpoch;
  }

  RemoteNote.fromSnapshot(DocumentSnapshot snapshot) {
    this.id = snapshot['id'];
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.created = snapshot['timestamp'];
  }

  Note toNote() => Note(id: id, title: title, description: description, created: created);
}
