import 'dart:async';

import 'package:domain/coordinators/notes_coordinator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_event.dart';
import 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final NotesCoordinator coordinator;

  AddBloc(this.coordinator) : super(InitialState());

  @override
  Stream<AddState> mapEventToState(AddEvent event) async* {
    switch (event.runtimeType) {
      case Save:
        {
          yield LoadingState();
          try {
            var note = (event as Save).note;
            var id = await coordinator.save(note);
            yield SavedState(id);
          } catch (e) {
            yield FailedState(e, "Error loading note details.");
          }
          break;
        }
      default:
        {
          yield FailedState(null, "Unknown event.");
        }
    }
  }
}
