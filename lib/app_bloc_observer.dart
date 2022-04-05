import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    print('$bloc created');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    print('$bloc closed');
    super.onClose(bloc);

  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$bloc error: $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('$bloc transition: $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print('$bloc change: $change');
    super.onChange(bloc, change);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    print('$bloc event: $event');
    super.onEvent(bloc, event);
  }
}
