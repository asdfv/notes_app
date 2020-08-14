class Note {
  final String id;
  final String title;
  final String description;
  final int created;

  Note({this.id, this.title, this.description, this.created});

  get createdFormat => DateTime.fromMillisecondsSinceEpoch(created).toIso8601String();
}
