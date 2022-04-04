import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lixshop/repositories/auth/auth_repository.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';

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
      final data = await authRepository.signInWithEmailAndPassword(event.login);
      await Future.delayed(const Duration(seconds: 1));

      if (data.err != 0) {
        emit(FailureAuthState(data.msg));
      } else {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenceToken(data.dt!);
        final user = await authRepository.currentUser();
        emit(SuccessAuthState(user!, data.dt!.accessToken!));
      }
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<AuthState> emit) async {
    try {
      if (await secureStorage.checkLogin()) {
        final user = await authRepository.currentUser();
        if (user != null) {
          print(user.address);
          final token = await secureStorage.readToken();
          emit(SuccessAuthState(user, token?.accessToken ?? ''));
        } else {
          emit(LogOutAuthState());
        }
      } else {
        emit(LogOutAuthState());
      }
    } catch (e) {
      print('error: $e');
      emit(LogOutAuthState());
    }
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());
      await authRepository.signOut();
      emit(LogOutAuthState());
    } catch (e) {
      emit(LogOutAuthState());
    }
    // emit(const AuthState());
  }
}
