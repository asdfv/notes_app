import 'package:notes_app/domain/errors/error_converter.dart';
import 'package:notes_app/domain/errors/errors.dart';

class NetworkErrorConverter extends ErrorConverter {
  @override
  NotesException convert(Exception error) {
      return RequestException(error.toString());
  }
}
