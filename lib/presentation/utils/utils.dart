import 'package:domain/domain_module.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension SnackbarInScaffold on BuildContext {
  void snack(String message) {
    Scaffold.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}

extension TimestampToString on int {
  String toFormattedDate() {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(this);
    final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    final String formatted = formatter.format(date);
    return formatted;
  }
}

List<Note> createFakeNotes() => List.generate(
    100,
    (index) => Note(
          id: null,
          created: DateTime.now().millisecondsSinceEpoch,
          title: "Note $index",
          description: "Note number $index description",
        ));
