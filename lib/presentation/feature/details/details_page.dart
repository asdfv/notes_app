import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/presentation/feature/details/details_event.dart';
import 'package:notes_app/presentation/feature/details/details_state.dart';

import 'details_arguments.dart';
import 'details_bloc.dart';

class DetailsPage extends StatelessWidget {
  final String title;
  final NotesCoordinator coordinator;

  DetailsPage({Key key, @required this.title, @required this.coordinator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
//    final DetailsArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider(
      create: (_) => DetailsBloc(coordinator),
      child: Builder(
        builder: (ctx) {
          BlocProvider.of<DetailsBloc>(ctx).add(DetailsAsked("1"));
          return BlocBuilder(builder: (_, state) => _buildWidgetFor(state));
        },
      ),
    );
  }

  Widget _buildWidgetFor(DetailsState state) {
    switch (state.runtimeType) {
      case Initial:
        return _buildInitial();
      case Loading:
        return _buildLoading();
      case DetailsReceived:
        return _buildDetails((state as DetailsReceived).note);
      case Failed:
        return _buildError(state as Failed);
      default:
        return _buildError();
    }
  }

  Text _buildInitial() => Text("We are waiting for details.");

  Widget _buildError([Failed state]) {
    if (state == null) {
      return Text("Error happened, oh my god!");
    } else {
      return Text("Error happened: ${state.reason}.");
    }
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildDetails(Note note) => Text(note.toString());
}
