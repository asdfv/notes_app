import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/presentation/feature/add/add_page.dart';
import 'package:notes_app/presentation/feature/details/details_arguments.dart';
import 'package:notes_app/presentation/feature/details/details_page.dart';
import 'package:notes_app/presentation/feature/notes/notes_event.dart';
import 'package:notes_app/presentation/utils/utils.dart';

import 'notes_bloc.dart';
import 'notes_state.dart';

class NotesPage extends StatefulWidget {
  static final String route = "/notes";
  final String title;
  final NotesCoordinator coordinator;

  NotesPage({Key key, @required this.title, @required this.coordinator}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Completer<void> _refreshCompleter = Completer<void>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesBloc>(
      create: (_) => NotesBloc(widget.coordinator)..add(NotesAsked()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (ctx, state) => _buildWidgetFor(ctx, state),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddPage(context),
          tooltip: 'Add note',
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  Future<Object> _navigateToAddPage(BuildContext context) => Navigator.pushNamed(context, AddPage.route);

  Widget _buildWidgetFor(BuildContext context, NotesState state) {
    switch (state.runtimeType) {
      case LoadingState:
        return _buildLoading();
      case NotesReceivedState:
        {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return _buildNotesList(context, (state as NotesReceivedState).notes);
        }
      case NoteDeletedState:
        {
          final notes = (state as NoteDeletedState).notes;
          return _buildNotesList(context, notes);
        }
      case DeletingFailedState:
        {
          final newState = (state as DeletingFailedState);
          context.snack("Error while deleting note. ${newState.reason}.");
          return _buildNotesList(context, newState.notes);
        }
      case LoadingFailedState:
        return _buildError(state as LoadingFailedState);
      default:
        return _buildError();
    }
  }

  Widget _buildError([LoadingFailedState state]) {
    if (state == null) {
      return Text("Error happened, oh my god!");
    } else {
      return Text("Error happened: ${state.reason}. Cause: ${state.cause}.");
    }
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  Widget _buildNotesList(BuildContext context, List<Note> notes) => RefreshIndicator(
        onRefresh: () {
          context.read<NotesBloc>().add(NotesAsked());
          return _refreshCompleter.future;
        },
        child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              var note = notes[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (_) {
                  context.read<NotesBloc>().add(DeleteNoteAsked(note.id, notes, index));
                },
                child: Card(
                  child: ListTile(
                      title: Text(note.title),
                      subtitle: Text("${note.description}"),
                      isThreeLine: true,
                      trailing: Text(note.created.toFormattedDate(), textAlign: TextAlign.left),
                      onTap: () => Navigator.pushNamed(
                            context,
                            DetailsPage.route,
                            arguments: DetailsArguments(id: note.id),
                          )),
                ),
              );
            }),
      );
}
