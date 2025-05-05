import 'package:assist_gui/core/utils/logger.dart';
import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    Logger.gray('Event: $event', name: 'BlocObserver');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    Logger.red('Error: $error', name: 'BlocObserver');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    Logger.gray(
      'Change: [ ${change.currentState.runtimeType} ] -> [ ${change.nextState.runtimeType} ]',
      name: 'BlocObserver',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    Logger.gray('Transition: $transition', name: 'BlocObserver');
  }

  @override
  void onCreate(BlocBase bloc) {
    Logger.gray('Create: ${bloc.runtimeType}', name: 'BlocObserver');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    Logger.gray('Close: ${bloc.runtimeType}', name: 'BlocObserver');
    super.onClose(bloc);
  }
}
