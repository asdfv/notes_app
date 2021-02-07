import 'dart:async';

import 'package:domain/coordinators/notes_coordinator.dart';
import 'package:domain/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation/feature/add/add_page.dart';
import 'package:notes_app/presentation/feature/notes/notes_event.dart';

import 'notes_bloc.dart';
import 'notes_list_widget.dart';
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
  List<Note> _notes = [];

  @override
  Widget build(BuildContext context) {
    NotesCoordinator notesCoordinator = widget.coordinator;
    String title = widget.title;

    return BlocProvider<NotesBloc>(
      create: (_) => NotesBloc(notesCoordinator)..add(LoadNotes()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: BlocBuilder<NotesBloc, NotesState>(
          builder: (ctx, state) => _buildWidgetFor(ctx, state),
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            onPressed: () {
              _navigateToAddPage(ctx);
            },
            tooltip: 'Add note',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }

  _navigateToAddPage(BuildContext context) async {
    final result = await Navigator.pushNamed(context, AddPage.route);
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }

  Widget _buildWidgetFor(BuildContext context, NotesState state) {
    switch (state.runtimeType) {
      case Loading:
        return _createLoading();
      case NotesReceived:
        {
          _refreshCompleter.complete();
          _refreshCompleter = Completer();
          _notes = (state as NotesReceived).notes;
          return NotesListWidget(
            notes: _notes,
            refreshCompleter: _refreshCompleter,
          );
        }
      case NoteDeleted:
        {
          var id = (state as NoteDeleted).id;
          _notes.removeWhere((element) => element.id == id);
          return NotesListWidget(
            notes: _notes,
            refreshCompleter: _refreshCompleter,
          );
        }
      case DeletingFailed:
        {
          final newState = (state as DeletingFailed);
          return NotesListWidget(
            notes: _notes,
            refreshCompleter: _refreshCompleter,
            errorMessage: newState.reason,
          );
        }
      case LoadingFailed:
        return _createError(state as LoadingFailed);
      default:
        return _createError();
    }
  }

  Widget _createError([LoadingFailed state]) {
    if (state == null) {
      return Text("Error happened, oh my god!");
    } else {
      return Text("Error happened: ${state.reason}. Cause: ${state.cause}.");
    }
  }

  Widget _createLoading() => Center(child: CircularProgressIndicator());
}
