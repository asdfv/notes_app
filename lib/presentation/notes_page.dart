import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/data/datasources/firestore_notes_datasource.dart';
import 'package:notes_app/data/repositories/stub_notes_repository.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/models/note.dart';

class NotesPage extends StatefulWidget {
  final String title;

  final NotesCoordinator coordinator = DefaultNotesCoordinator(
      StubNoteRepository(FirestoreNotesDatasource(Firestore.instance)));

  NotesPage({Key key, this.title}) : super(key: key);

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Future<List<Note>> _notes;

  void _loadNote() {
    setState(() {
      _notes = widget.coordinator.getNotes();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: FutureBuilder<List<Note>>(
          future: _notes,
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
          onPressed: _loadNote,
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
