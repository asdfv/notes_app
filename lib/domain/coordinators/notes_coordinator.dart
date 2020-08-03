import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';

abstract class NotesCoordinator {
  Future<Note> getNote(String id);

  Future<List<Note>> getNotes();
}

class DefaultNotesCoordinator extends NotesCoordinator {
  final NotesRepository notesRepository;

  DefaultNotesCoordinator(this.notesRepository);

  @override
  Future<Note> getNote(String id) => notesRepository.getNote(id);

  @override
  Future<List<Note>> getNotes() => notesRepository.getNotes();
}
