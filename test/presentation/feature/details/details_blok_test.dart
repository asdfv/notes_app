import 'package:bloc_test/bloc_test.dart';
import 'package:domain/domain_module.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:notes_app/presentation/feature/details/details_bloc.dart';
import 'package:notes_app/presentation/feature/details/details_event.dart';
import 'package:notes_app/presentation/feature/details/details_state.dart';

class MockNotesCoordinator extends Mock implements NotesCoordinator {}

void main() {
  NotesCoordinator coordinator;
  DetailsBloc bloc;
  final id = "testId";
  final testNote = Note(id: id, created: 1321, description: "Descr", title: "test");

  setUp(() {
    coordinator = MockNotesCoordinator();
    when(coordinator.getNote(id)).thenAnswer((_) => Future.value(testNote));
    bloc = DetailsBloc(coordinator);
  });

  tearDown(() {
    bloc.close();
  });

  group('DetailsBlock', () {
    blocTest(
      'LoadDetails event triggers details receiving.',
      build: () => bloc,
      act: (bloc) => bloc.add(LoadDetails(id)),
      expect: [Loading(), DetailsReceived(testNote)],
    );
  });
}
