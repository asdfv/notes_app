import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/presentation/feature/notes/notes_event.dart';

import 'notes_bloc.dart';
import 'notes_state.dart';

class NotesPage extends StatelessWidget {
  final String title;

  NotesPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(title),
      ),
      body: BlocBuilder<NotesBloc, NotesState>(builder: (context, state) => _buildWidgetFor(state)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => BlocProvider.of<NotesBloc>(context).add(NotesAsked()),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildWidgetFor(NotesState state) {
    switch (state.runtimeType) {
      case Initial:
        return _buildInitial();
      case Loading:
        return _buildLoading();
      case NotesReceived:
        return _buildNotesList((state as NotesReceived).notes);
      case Failed:
        return _buildError(state as Failed);
      default:
        return _buildError();
    }
  }

  Text _buildInitial() => Text("Push the button to load notes.");

  Widget _buildError([Failed state]) {
    if (state == null) {
      return Text("Error happened, oh my god!");
    } else {
      return Text("Error happened: ${state.reason}.");
    }
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());

  ListView _buildNotesList(List<Note> notes) => ListView.builder(
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) => Container(
            height: 50,
            child: Center(child: Text('Note: ${notes[index].title}')),
          ));
}
