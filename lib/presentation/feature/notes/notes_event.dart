abstract class NotesEvent {}

class NotesAsked extends NotesEvent {}
class DetailsAsked extends NotesEvent {
  final String id;

  DetailsAsked(this.id);
}