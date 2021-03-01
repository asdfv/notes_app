import 'package:data/src/models/remote_note.dart';

import 'notes_datasource.dart';

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
  Future<RemoteNote> save(RemoteNote note) {
    var id = DateTime.now().millisecondsSinceEpoch.toString();
    _notes[id] = note;
    return Future.delayed(
      Duration(milliseconds: 300),
      () => note,
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
