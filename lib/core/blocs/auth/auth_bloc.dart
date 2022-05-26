import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:lixshop/utils/helpers/secure_storage.dart';

import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<AuthLoggedEvent>(_onLogin);
    on<CheckLoginEvent>(_onCheckLogin);
    on<AuthLogoutEvent>(_onLogOut);
  }

  Future<void> _onLogin(AuthLoggedEvent event, Emitter<AuthState> emit) async {
    print('_onLogin');
    try {
      emit(LoadingAuthState());
      final data = await authRepository.signInWithEmailAndPassword(event.login);
      print(data.msg);
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
          emit(LogoutAuthState());
        }
      } else {
        emit(LogoutAuthState());
      }
    } catch (e) {
      print('error: $e');
      emit(LogoutAuthState());
    }
  }

  Future<void> _onLogOut(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());
      await authRepository.signOut();
      emit(LogoutAuthState());
    } catch (e) {
      emit(LogoutAuthState());
    }
    // emit(const AuthState());
  }
}
