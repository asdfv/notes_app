import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String title;
  final String description;
  final int created;

  Note({this.id, this.title, this.description, this.created});

  @override
  List<Object> get props => [id];
}
