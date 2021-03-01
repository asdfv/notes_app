import 'package:domain/domain_module.dart';

abstract class AddEvent {}

class Save extends AddEvent {
  final Note note;

  Save(this.note);
}
