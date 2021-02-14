import 'dart:async';

import 'package:domain/coordinators/notes_coordinator.dart';
import 'package:domain/errors/errors.dart';
import 'package:domain/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesCoordinator coordinator;
  List<Note> _notes = [];

  NotesBloc(this.coordinator) : super(Loading());

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    switch (event.runtimeType) {
      case LoadNotes:
        {
          yield Loading();
          try {
            List<Note> notes = await coordinator.getNotes();
            _notes = notes;
            yield NotesUpdated(_notes);
          } on NotesException catch (e) {
            yield LoadingFailed(e, "Error loading notes.");
          }
          break;
        }
      case DeleteNote:
        {
          final String id = (event as DeleteNote).id;
          try {
            await coordinator.delete(id);
            _notes.removeWhere((element) => element.id == id);
            yield NotesUpdated(_notes);
          } on NotesException catch (e) {
            yield DeletingFailed("Error while delete note $id. ${e.message}");
          }
          break;
        }
      case NoteAdded:
        {
          var note = (event as NoteAdded).note;
          _notes.add(note);
          yield NotesUpdated(_notes);
          break;
        }
      default:
        {
          yield LoadingFailed(null, "Unknown event.");
        }
    }
  }
}
