import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/datasources/fake_notes_datasource.dart';
import 'package:data/datasources/firestore_notes_datasource.dart';
import 'package:data/error/network_error_convertor.dart';
import 'package:data/repositories/default_notes_repository.dart';
import 'package:domain/domain_module.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation/feature/add/add_page.dart';
import 'package:notes_app/presentation/feature/details/details_page.dart';

import 'bloc/simple_bloc_observer.dart';
import 'feature/notes/notes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await Firebase.initializeApp();
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  final NotesCoordinator notesCoordinator = DefaultNotesCoordinator(
      DefaultNotesRepository(FakeNotesDatasource(), FirestoreNotesDatasource(FirebaseFirestore.instance)),
      NetworkErrorConverter());

  @override
  Widget build(BuildContext context) {
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
