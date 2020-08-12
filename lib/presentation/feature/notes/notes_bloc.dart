import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/models/note.dart';

import 'notes_event.dart';
import 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesCoordinator coordinator;

  NotesBloc(this.coordinator) : super(Initial());

  @override
  Stream<NotesState> mapEventToState(NotesEvent event) async* {
    switch (event.runtimeType) {
      case NotesAsked:
        {
          yield Loading();
          try {
            var notes = await coordinator.getNotes();
            if (notes.length > 1)
              yield NotesReceived(notes);
            else
              yield NotesReceived([Note(title: "Title", description: "Desc", created: 1231321)]);
          } catch (e) {
            yield Failed(e, "Error loading notes.");
          }
          break;
        }
      default:
        {
          yield Failed(null, "Unknown event.");
        }
    }
  }
}
