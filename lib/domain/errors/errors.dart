abstract class NotesException implements Exception {
  final String message;

  NotesException(this.message);
}

class RequestException implements NotesException {
  final String message;

  RequestException(this.message);

  @override
  String toString() => 'Request to the server failed. $message';
}

class DeleteError implements NotesException {
  final String message;

  DeleteError(this.message);

  @override
  String toString() => 'Cannot delete this. $message';
}

class UnknownError implements NotesException {
  final String message;

  UnknownError(this.message);

  @override
  String toString() => 'Something wrong happened. $message';
}
