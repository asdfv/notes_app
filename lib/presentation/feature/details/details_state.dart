import 'package:domain/domain_module.dart';
import 'package:equatable/equatable.dart';

abstract class DetailsState with EquatableMixin {}

class Initial extends DetailsState {
  @override
  List<Object> get props => [];
}

class Loading extends DetailsState {
  @override
  List<Object> get props => [];
}

class Failed extends DetailsState {
  final Object cause;
  final String reason;

  Failed(this.cause, this.reason);

  @override
  List<Object> get props => [cause, reason];
}

class DetailsReceived extends DetailsState {
  final Note note;

  DetailsReceived(this.note);

  @override
  List<Object> get props => [note];
}
