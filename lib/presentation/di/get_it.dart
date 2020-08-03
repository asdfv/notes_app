import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:notes_app/data/datasources/firestore_notes_datasource.dart';
import 'package:notes_app/data/datasources/notes_datasource.dart';
import 'package:notes_app/data/repositories/stub_notes_repository.dart';
import 'package:notes_app/domain/coordinators/notes_coordinator.dart';
import 'package:notes_app/domain/repositories/notes_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt
    ..registerLazySingleton(() => Firestore.instance)
    ..registerLazySingleton<NotesDatasource>(
        () => FirestoreNotesDatasource(getIt<Firestore>()))
    ..registerLazySingleton<NotesRepository>(
        () => StubNoteRepository(getIt<NotesDatasource>()))
    ..registerLazySingleton<NotesCoordinator>(
        () => DefaultNotesCoordinator(getIt<NotesRepository>()));
}
