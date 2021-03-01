import 'dart:async';

import 'package:domain/domain_module.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'details_event.dart';
import 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final NotesCoordinator coordinator;

  DetailsBloc(this.coordinator) : super(Initial());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    switch (event.runtimeType) {
      case LoadDetails:
        {
          yield Loading();
          try {
            var id = (event as LoadDetails).id;
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
