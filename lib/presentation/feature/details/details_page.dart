import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/presentation/feature/details/details_event.dart';
import 'package:notes_app/presentation/feature/details/details_state.dart';
import 'package:notes_app/presentation/utils/utils.dart';

import 'details_arguments.dart';
import 'details_bloc.dart';

class DetailsPage extends StatelessWidget {
  final NotesCoordinator coordinator;
  static final String route = "/details";

  DetailsPage({Key key, @required this.coordinator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailsArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<DetailsBloc>(
      create: (_) => DetailsBloc(coordinator),
      child: Builder(
        builder: (ctx) {
          BlocProvider.of<DetailsBloc>(ctx).add(DetailsAsked(args.id));
          return BlocBuilder<DetailsBloc, DetailsState>(builder: (_, state) => _buildWidgetFor(state));
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

  Widget _buildDetails(Note note) => Scaffold(
        appBar: AppBar(title: Text("Details for ${note.title}")),
        body: _detailsWidget(note),
      );

  Container _detailsWidget(Note note) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          _twinItemWidget("ID", note.id),
          _twinItemWidget("Title", note.title),
          _twinItemWidget("Description", note.description),
          _twinItemWidget("Created", note.created.toFormattedDate()),
        ],
      ),
    );
  }

  Column _twinItemWidget(String label, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10.0),
        ),
      ],
    );
  }
}
