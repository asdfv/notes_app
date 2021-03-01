import 'package:domain/domain_module.dart';

abstract class DetailsState {}

class Initial extends DetailsState {}

class Loading extends DetailsState {}

class Failed extends DetailsState {
  final Object cause;
  final String reason;

  Failed(this.cause, this.reason);
}

class DetailsReceived extends DetailsState {
  final Note note;

  DetailsReceived(this.note);
}
