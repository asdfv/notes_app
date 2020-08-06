import 'package:flutter/material.dart';
import 'package:notes_app/presentation/bloc/bloc_provider.dart';
import 'package:notes_app/presentation/notes/notes_bloc.dart';
import 'package:notes_app/presentation/notes_page.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: NotesBloc(),
      child: MaterialApp(
        title: 'Note app',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NotesPage(title: 'Your notes'),
      ),
    );
  }
}
