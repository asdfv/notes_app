import 'package:notes_app/data/datasources/notes_datasource.dart';
import 'package:notes_app/data/models/remote_note.dart';

class FakeNotesDatasource extends NotesDatasource {
  Map<String, RemoteNote> _notes = Map.fromIterable(List.generate(300, (index) => index),
      key: (index) => index.toString(),
      value: (index) =>
          RemoteNote(id: index.toString(), title: "Title $index", description: "Desc $index", created: index));

  @override
  Future<RemoteNote> getNote(String id) => Future.delayed(
        Duration(milliseconds: 300),
        () => _notes[id],
      );

  @override
  Future<List<RemoteNote>> getNotes() => Future.delayed(Duration(milliseconds: 300), () => _notes.values.toList());

  @override
  Future<String> save(RemoteNote note) {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    _notes[id] = note;
    return Future.delayed(
      Duration(milliseconds: 300),
      () => id,
    );
  }

  @override
  Future<void> delete(String id) {
    return Future.delayed(
      Duration(milliseconds: 300),
      () => _notes.remove(id),
    );
  }
}
