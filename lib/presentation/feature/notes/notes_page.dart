import 'dart:async';

import 'package:domain/coordinators/notes_coordinator.dart';
import 'package:domain/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return _createLoading();
      case NotesReceivedState:
        {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          return NotesListWidget(
            notes: (state as NotesReceivedState).notes,
            refreshCompleter: _refreshCompleter,
          );
          // return _createNotesList(context, (state as NotesReceivedState).notes);
        }
      case NoteDeletedState:
        {
          final notes = (state as NoteDeletedState).notes;
          return NotesListWidget(
            notes: notes,
            refreshCompleter: _refreshCompleter,
          );
          // return _createNotesList(context, notes);
        }
      case DeletingFailedState:
        {
          final newState = (state as DeletingFailedState);
          return NotesListWidget(
            notes: newState.notes,
            refreshCompleter: _refreshCompleter,
            errorMessage: newState.reason,
          );
        }
      case LoadingFailedState:
        return _createError(state as LoadingFailedState);
      default:
        return _createError();
    }
  }

  Widget _createError([LoadingFailedState state]) {
    if (state == null) {
      return Text("Error happened, oh my god!");
    } else {
      return Text("Error happened: ${state.reason}. Cause: ${state.cause}.");
    }
  }

  Widget _createLoading() => Center(child: CircularProgressIndicator());
}

class NotesListWidget extends StatelessWidget {
  final List<Note> notes;
  final String errorMessage;
  final Completer<void> refreshCompleter;

  const NotesListWidget({Key key, this.notes, this.errorMessage, this.refreshCompleter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.snack(errorMessage);
      });
    }
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<NotesBloc>(context).add(NotesAsked());
        return refreshCompleter.future;
      },
      child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (BuildContext context, int index) {
            var note = notes[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (_) {
                BlocProvider.of<NotesBloc>(context).add(DeleteNoteAsked(note.id, notes, index));
              },
              child: Card(
                child: ListTile(
                    title: Text(note.title),
                    subtitle: Text(note.description),
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
}
