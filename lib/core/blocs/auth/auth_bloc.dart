import 'dart:async';
import 'dart:convert';

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
      if (data.err != 0) {
        emit(FailureAuthState(data.msg!.contains("null check")
            ? "Có lỗi xảy ra, vui lòng thử lại sau!"
            : data.msg));
      } else {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenceToken(data.dt!);
        final user = await authRepository.currentUser();
        await secureStorage.saveCurrentUser(jsonEncode(user!.user!.toJson()));
        emit(SuccessAuthState(user.user!, data.dt!.accessToken!));
      }
    } catch (e) {
      emit(FailureAuthState("Có lỗi xảy ra, vui lòng thử lại sau"));
    }
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<AuthState> emit) async {
    try {
      if (await secureStorage.checkLogin()) {
        final user = await authRepository.currentUser();
        if (user != null && user.isLoggedIn!) {
          await secureStorage.saveCurrentUser(jsonEncode(user.user!.toJson()));
          final token = await secureStorage.readToken();
          emit(SuccessAuthState(user.user!, token?.accessToken ?? ''));
        } else if (user!.isError!) {
          emit(FailureAuthState("Có lỗi xảy ra, vui lòng thử lại sau"));
        }
      } else {
        await secureStorage.deleteSecureStorage();
        emit(LogoutAuthState());
      }
    } catch (e) {
      emit(FailureAuthState("Có lỗi xảy ra, vui lòng thử lại sau"));
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
  }
}
