import 'package:notes_app/domain/models/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RemoteNote {
  String title;
  String description;
  int timestamp;

  RemoteNote(this.title, this.description);

  RemoteNote.fromSnapshot(DocumentSnapshot snapshot) {
    this.title = snapshot['title'];
    this.description = snapshot['description'];
    this.timestamp = snapshot['timestamp'];
  }

  Note toNote() => Note(title, description);
}
