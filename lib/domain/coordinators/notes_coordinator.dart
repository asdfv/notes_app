import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';

abstract class NotesCoordinator {
  Future<Note> getNote(String id);
  Future<List<Note>> getNotes();
  Future<String> save(Note note);
  Future<void> delete(String id);
}

class DefaultNotesCoordinator extends NotesCoordinator {
  final NotesRepository notesRepository;

  DefaultNotesCoordinator(this.notesRepository);

  @override
  Future<Note> getNote(String id) => notesRepository.getNote(id);

  @override
  Future<List<Note>> getNotes() => notesRepository.getNotes();

  @override
  Future<String> save(Note note) {
    return notesRepository.save(note);
  }

  @override
  Future<void> delete(String id) async {
    await notesRepository.delete(id);
  }
}
