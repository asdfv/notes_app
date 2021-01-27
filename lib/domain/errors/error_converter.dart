import 'package:notes_app/domain/errors/errors.dart';

abstract class ErrorConverter {
  NotesException convert(Exception error);
}
