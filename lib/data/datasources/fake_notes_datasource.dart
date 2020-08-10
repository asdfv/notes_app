import 'package:notes_app/data/datasources/notes_datasource.dart';
import 'package:notes_app/data/models/remote_note.dart';

class FakeNotesDatasource extends NotesDatasource {
  @override
  Future<RemoteNote> getNote(String id) => Future.delayed(
        Duration(seconds: 1),
        () => RemoteNote(id: 1321321, title: "Title", description: "Desc", created: 1231321),
      );

  @override
  Future<List<RemoteNote>> getNotes() => Future.delayed(
      Duration(seconds: 1),
      () => List.generate(
            100,
            (index) => RemoteNote(id: index, title: "Title $index", description: "Desc $index", created: index),
          ));
}
