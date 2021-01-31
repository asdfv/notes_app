import 'package:domain/errors/error_converter.dart';
import 'package:domain/models/note.dart';
import 'package:domain/repositories/notes_repository.dart';

abstract class NotesCoordinator {
  Future<Note> getNote(String id);

  Future<List<Note>> getNotes();

  Future<String> save(Note note);

  Future<void> delete(String id);
}

class DefaultNotesCoordinator extends NotesCoordinator {
  final NotesRepository notesRepository;
  final ErrorConverter errorConverter;

  DefaultNotesCoordinator(this.notesRepository, this.errorConverter);

  @override
  Future<Note> getNote(String id) => notesRepository.getNote(id).catchError((error) {
        throw errorConverter.convert(error);
      });

  @override
  Future<List<Note>> getNotes() => notesRepository.getNotes().catchError((error) {
        throw errorConverter.convert(error);
      });

  @override
  Future<String> save(Note note) {
    return notesRepository.save(note).catchError((error) {
      throw errorConverter.convert(error);
    });
  }

  @override
  Future<void> delete(String id) {
    return notesRepository.delete(id).catchError((error) {
      throw errorConverter.convert(error);
    });
  }
}
