import 'dart:async';

import 'package:domain/coordinators/notes_coordinator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_event.dart';
import 'add_state.dart';

class AddBloc extends Bloc<AddEvent, AddState> {
  final NotesCoordinator coordinator;

  AddBloc(this.coordinator) : super(Initial());

  @override
  Stream<AddState> mapEventToState(AddEvent event) async* {
    switch (event.runtimeType) {
      case Save:
        {
          yield Loading();
          try {
            var note = (event as Save).note;
            var id = await coordinator.save(note);
            yield Saved(id);
          } catch (e) {
            yield Failed(e, "Error while saving note.");
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
