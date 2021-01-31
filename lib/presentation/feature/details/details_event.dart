abstract class DetailsEvent {}

class LoadDetails extends DetailsEvent {
  final String id;

  LoadDetails(this.id);
}
