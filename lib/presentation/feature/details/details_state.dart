import 'package:notes_app/domain/models/note.dart';

abstract class DetailsState {}

class Initial extends DetailsState {}

class Loading extends DetailsState {}

class Failed extends DetailsState {
  final Exception cause;
  final String reason;

  Failed(this.cause, this.reason);
}

class DetailsReceived extends DetailsState {
  final Note note;

  DetailsReceived(this.note);
}
