import 'package:domain/models/note.dart';

abstract class AddEvent {}

class Save extends AddEvent {
  final Note note;

  Save(this.note);
}
