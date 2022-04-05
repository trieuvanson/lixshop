


import 'package:flutter_bloc/flutter_bloc.dart';

import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(index: 0));

  void changeNavigation(int index) {
    emit(state.copyWith(index: index));
  }
}
