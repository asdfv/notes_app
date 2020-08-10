import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/datasources/firestore_notes_datasource.dart';
import 'package:notes_app/data/repositories/stub_notes_repository.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';

import 'bloc/simple_bloc_observer.dart';
import 'feature/notes/notes_bloc.dart';
import 'feature/notes/notes_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final NotesCoordinator coordinator =
      DefaultNotesCoordinator(StubNoteRepository(FirestoreNotesDatasource(Firestore.instance)));
  runApp(NotesApp(coordinator));
}

class NotesApp extends StatelessWidget {
  final NotesCoordinator coordinator;

  NotesApp(this.coordinator);

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NotesBloc(coordinator),
      child: MaterialApp(
        title: 'Notes app',
        home: NotesPage(title: 'Your notes'),
      ),
    );
//    return MultiBlocProvider(
//      providers: [
//        BlocProvider<NotesBloc>(create: (_) => NotesBloc(coordinator)),
//      ],
//      child: MaterialApp(
//        title: 'Notes app',
//        home: NotesPage(title: 'Your notes'),
//      ),
//    );
  }
}
