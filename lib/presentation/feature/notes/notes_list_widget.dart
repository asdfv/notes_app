import 'dart:async';

import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/presentation/feature/notes/notes_event.dart';
import 'package:notes_app/presentation/utils/utils.dart';

import 'notes_bloc.dart';
import 'notes_list_item.dart';

class NotesListWidget extends StatefulWidget {
  final List<Note> notes;
  final String errorMessage;
  final Completer<void> refreshCompleter;

  const NotesListWidget({Key key, this.notes, this.errorMessage, this.refreshCompleter}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NotesListWidgetState();
}

class _NotesListWidgetState extends State<NotesListWidget> {
  @override
  Widget build(BuildContext context) {
    var errorMessage = widget.errorMessage;
    var refreshCompleterFuture = widget.refreshCompleter.future;
    var notes = widget.notes;

    if (errorMessage != null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        context.snack(errorMessage);
      });
    }
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<NotesBloc>(context).add(LoadNotes());
        return refreshCompleterFuture;
      },
      child: ListView.builder(
          itemCount: notes.length,
          itemBuilder: (context, index) {
            var note = notes[index];
            return NotesListItem(
              note: note,
              onRemove: () {
                BlocProvider.of<NotesBloc>(context).add(DeleteNote(note.id));
              },
            );
          }),
    );
  }
}
