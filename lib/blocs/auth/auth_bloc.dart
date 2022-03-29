import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lixshop/repositories/auth/auth_repository.dart';

import '../../models/models.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<LoginEvent>(_onLogin);
    on<CheckLoginEvent>(_onCheckLogin);
    on<LogOutEvent>(_onLogOut);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());

      ResponseDTO data = await authRepository.signInWithEmailAndPassword(event.login);
      await Future.delayed(const Duration(seconds: 1));

      print('data: $data');

      if (data.err == -1) {
        emit(FailureAuthState(data.msg));
      } else if (data.err == 0) {
        final user = await authRepository.currentUser();
        emit(SuccessAuthState(user, data.dt!.accessToken!));
      } else {
        print('Error: ${data.err}');
        emit(FailureAuthState(data.msg));
      }
    } catch (e) {
      print('Error: $e');
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<AuthState> emit) async {}

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {}
}
