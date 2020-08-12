import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';

import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final NotesCoordinator coordinator;

  DetailsBloc(this.coordinator) : super(Initial());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    switch (event.runtimeType) {
      case DetailsAsked:
        {
          yield Loading();
          try {
            var id = (event as DetailsAsked).id;
            var details = await coordinator.getNote(id);
            yield DetailsReceived(details);
          } catch (e) {
            yield Failed(e, "Error loading note details.");
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
