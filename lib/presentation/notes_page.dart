import 'package:flutter/material.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/presentation/notes/notes_bloc.dart';

import 'bloc/bloc_provider.dart';

class NotesPage extends StatefulWidget {
  final String title;

  NotesPage({Key key, this.title}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<NotesBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: StreamBuilder<List<Note>>(
          stream: bloc.notes,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return buildNotesList(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => bloc.loadNotes(),
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }

  ListView buildNotesList(List<Note> notes) => ListView.builder(
      itemCount: notes.length,
      itemBuilder: (BuildContext context, int index) => Container(
            height: 50,
            child: Center(child: Text('Note: ${notes[index].title}')),
          ));
}
