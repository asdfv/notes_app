import 'package:domain/domain_module.dart';

abstract class AddState {}

class Initial extends AddState {}

class Loading extends AddState {}

class Failed extends AddState {
  final Object cause;
  final String reason;

  Failed(this.cause, this.reason);
}

class Saved extends AddState {
  final Note note;

  Saved(this.note);
}
