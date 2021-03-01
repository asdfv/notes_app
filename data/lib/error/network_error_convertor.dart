import 'package:domain/domain_module.dart';

class NetworkErrorConverter extends ErrorConverter {
  @override
  NotesException convert(Exception error) {
    return RequestException(error.toString());
  }
}
