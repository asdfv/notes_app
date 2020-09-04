abstract class AddState {}

class InitialState extends AddState {}
class LoadingState extends AddState {}

class FailedState extends AddState {
  final Object cause;
  final String reason;

  FailedState(this.cause, this.reason);
}

class SavedState extends AddState {
  final String id;

  SavedState(this.id);
}
