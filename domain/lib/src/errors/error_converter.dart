import 'errors.dart';

abstract class ErrorConverter {
  NotesException convert(Exception error);
}
