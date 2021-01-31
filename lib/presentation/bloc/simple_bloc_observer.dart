import 'package:domain/utilities/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocObserver extends BlocObserver {
  var log = getLogger();

  @override
  void onEvent(Bloc bloc, Object event) {
    log.d(message: event.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onChange(Cubit cubit, Change change) {
    log.d(message: change.toString());
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log.d(message: transition.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    log.d(message: error.toString());
    super.onError(cubit, error, stackTrace);
  }
}
