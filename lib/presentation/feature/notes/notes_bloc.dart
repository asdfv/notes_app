import 'dart:async';

import 'package:domain/coordinators/notes_coordinator.dart';
import 'package:domain/errors/errors.dart';
import 'package:domain/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesCoordinator coordinator;

  NotesBloc(this.coordinator) : super(Loading());

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    switch (event.runtimeType) {
      case LoadNotes:
        {
          yield Loading();
          try {
            List<Note> notes = await coordinator.getNotes();
            yield NotesReceived(notes);
          } on NotesException catch (e) {
            yield LoadingFailed(e, "Error loading notes.");
          }
          break;
        }
      case DeleteNote:
        {
          final String id = (event as DeleteNote).id;
          final List<Note> notes = (event as DeleteNote).notes;
          final int index = (event as DeleteNote).index;
          try {
            await coordinator.delete(id);
            notes.removeAt(index);
            yield NoteDeleted(id, notes);
          } on NotesException catch (e) {
            yield DeletingFailed("Error while delete note $id. ${e.message}", notes);
          }
          break;
        }
      default:
        {
          yield LoadingFailed(null, "Unknown event.");
        }
    }
  }
}
