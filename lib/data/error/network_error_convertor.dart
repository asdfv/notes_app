import 'package:domain/errors/error_converter.dart';
import 'package:domain/errors/errors.dart';

class NetworkErrorConverter extends ErrorConverter {
  @override
  NotesException convert(Exception error) {
    return RequestException(error.toString());
  }
}
