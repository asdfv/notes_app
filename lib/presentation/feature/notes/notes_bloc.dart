import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/models/note.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesCoordinator coordinator;

  NotesBloc(this.coordinator) : super(LoadingState());

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    print("Event received from NotesScreen: $event.");
    switch (event.runtimeType) {
      case NotesAsked:
        {
          yield LoadingState();
          try {
            var notes = await coordinator.getNotes();
            yield NotesReceivedState(notes);
          } catch (e) {
            yield LoadingFailedState(e, "Error loading notes.");
          }
          break;
        }
      case DeleteNoteAsked:
        {
          final String id = (event as DeleteNoteAsked).id;
          final List<Note> notes = (event as DeleteNoteAsked).notes;
          final int index = (event as DeleteNoteAsked).index;
          try {
            await coordinator.delete(id);
            notes.removeAt(index);
            yield NoteDeletedState(id, notes);
          } catch (e) {
            yield DeletingFailedState(e, "Error while delete note $id.", notes);
          }
          break;
        }
      default:
        {
          yield LoadingFailedState(null, "Unknown event.");
        }
    }
  }
}
