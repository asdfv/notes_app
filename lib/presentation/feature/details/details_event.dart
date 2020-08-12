abstract class DetailsEvent {}

class DetailsAsked extends DetailsEvent {
  final String id;

  DetailsAsked(this.id);
}