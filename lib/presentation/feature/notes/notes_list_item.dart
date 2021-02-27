import 'package:domain/models/note.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/presentation/feature/details/details_arguments.dart';
import 'package:notes_app/presentation/feature/details/details_page.dart';
import 'package:notes_app/presentation/utils/utils.dart';

class NotesListItem extends StatelessWidget {
  final Note note;
  final Function onRemove;

  const NotesListItem({Key key, this.note, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (_) {
        onRemove.call();
      },
      child: Card(
        child: ListTile(
            title: Text(note.title),
            subtitle: Text(note.description),
            isThreeLine: true,
            trailing: Text(note.created.toFormattedDate(), textAlign: TextAlign.left),
            onTap: () => Navigator.pushNamed(
                  context,
                  DetailsPage.route,
                  arguments: DetailsArguments(id: note.id),
                )),
      ),
    );
  }
}
