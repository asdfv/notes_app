import 'package:logger/logger.dart';

NotesLogger getLogger() {
  final logger = Logger(
      printer: PrettyPrinter(
    methodCount: 0,
    errorMethodCount: 5,
    lineLength: 50,
    colors: true,
    printEmojis: true,
  ));
  return SimpleNotesLogger(logger);
}

abstract class NotesLogger {
  void v({String message, Exception error});

  void d({String message, Exception error});

  void i({String message, Exception error});

  void w({String message, Exception error});

  void e({String message, Exception error});
}

class SimpleNotesLogger extends NotesLogger {
  final Logger logger;

  SimpleNotesLogger(this.logger);

  @override
  void v({String message, Exception error}) {
    logger.v(message, error);
  }

  @override
  void d({String message, Exception error}) {
    logger.d(message, error);
  }

  @override
  void i({String message, Exception error}) {
    logger.i(message, error);
  }

  @override
  void e({String message, Exception error}) {
    logger.e(message, error);
  }

  @override
  void w({String message, Exception error}) {
    logger.w(message, error);
  }
}
