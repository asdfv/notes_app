import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:notes_app/data/datasources/firestore_notes_datasource.dart';
import 'package:notes_app/data/repositories/stub_notes_repository.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/models/note.dart';
import 'package:notes_app/presentation/bloc/bloc.dart';

class NotesBloc extends Bloc {
  final NotesCoordinator coordinator = DefaultNotesCoordinator(
      StubNoteRepository(FirestoreNotesDatasource(Firestore.instance)));

  StreamController<List<Note>> _notes = StreamController();

  Stream<List<Note>> get notes => _notes.stream;

  void loadNotes() {
    _notes.sink.add([]);
    coordinator.getNotes().then((notes) => _notes.sink.add(notes));
  }

  @override
  void dispose() {
    _notes.close();
  }
}

class NotesModel {
  final List<Note> notes;
  final bool isLoading;

  NotesModel(this.notes, this.isLoading);
}
