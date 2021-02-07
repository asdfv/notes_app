abstract class NotesEvent {}

class LoadNotes extends NotesEvent {}

class OpenDetails extends NotesEvent {
  final String id;

  OpenDetails(this.id);
}

class DeleteNote extends NotesEvent {
  final String id;

  DeleteNote(this.id);
}
