import 'package:domain/domain_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/presentation/feature/notes/notes_bloc.dart';
import 'package:notes_app/presentation/feature/notes/notes_event.dart';
import 'package:notes_app/presentation/feature/notes/notes_state.dart';

class MockNotesCoordinator extends Mock implements NotesCoordinator {}

void main() {
  NotesCoordinator coordinator;
  NotesBloc bloc;
  final testNote = Note(id: "id1", created: 1321, description: "Descr", title: "test");

  setUp(() {
    coordinator = MockNotesCoordinator();
    when(coordinator.getNotes()).thenAnswer((_) => Future.value([testNote]));
    bloc = NotesBloc(coordinator);
  });

  tearDown(() {
    bloc.close();
  });

  group('LoadNotes', () {
    test('LoadNotes event triggers correct states, positive case', () async {
      final exceptedSequence = [
        Loading(),
        NotesUpdated([testNote]),
        emitsDone
      ];

      await expectLater(bloc.mapEventToState(LoadNotes()), emitsInOrder(exceptedSequence),
          reason: "LoadNotes triggered wrong states sequence or states contains wrong data.");
    });

    test('LoadNotes event triggers correct states, negative case', () async {
      when(coordinator.getNotes()).thenAnswer((_) => Future.error(RequestException("Oh no")));

      final exceptedSequence = [Loading(), isA<LoadingFailed>(), emitsDone];

      await expectLater(bloc.mapEventToState(LoadNotes()), emitsInOrder(exceptedSequence),
          reason: "LoadNotes error triggered wrong states sequence or states contains wrong data.");
    });
  });
}
