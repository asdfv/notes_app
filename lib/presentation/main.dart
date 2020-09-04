import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/data/datasources/fake_notes_datasource.dart';
import 'package:notes_app/data/datasources/firestore_notes_datasource.dart';
import 'package:notes_app/data/repositories/default_notes_repository.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/presentation/feature/add/add_page.dart';
import 'package:notes_app/presentation/feature/details/details_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bloc/simple_bloc_observer.dart';
import 'feature/notes/notes_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  Widget build(BuildContext context) {
    final NotesCoordinator notesCoordinator = DefaultNotesCoordinator(
        DefaultNotesRepository(FakeNotesDatasource(), FirestoreNotesDatasource(Firestore.instance)));
    return MaterialApp(
      title: 'Notes app',
      initialRoute: NotesPage.route,
      routes: {
        NotesPage.route: (context) => NotesPage(
              title: 'Your notes',
              coordinator: notesCoordinator,
            ),
        DetailsPage.route: (context) => DetailsPage(
              coordinator: notesCoordinator,
            ),
        AddPage.route: (context) => AddPage(
              coordinator: notesCoordinator,
            ),
      },
    );
  }
}
