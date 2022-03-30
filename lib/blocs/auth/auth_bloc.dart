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
      final data =
          await authRepository.signInWithEmailAndPassword(event.login);
      await Future.delayed(const Duration(seconds: 1));

      if (data.err != 0) {
        emit(FailureAuthState(data.msg));
      } else  {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenceToken(data.dt!);
        final user = await authRepository.currentUser();
        // Lấy phường xã từ token


        print('token: ${data.dt!.accessToken}');
        emit(SuccessAuthState(user!, data.dt!.accessToken!));
      }
    } catch (e) {
      emit(FailureAuthState(e.toString()));
    }
  }

  Future<void> _onCheckLogin(
      CheckLoginEvent event, Emitter<AuthState> emit) async {
    try {
      emit(LoadingAuthState());
      final user = await authRepository.currentUser();
      await Future.delayed(const Duration(seconds: 1));
      if (user != null) {
        final token = await secureStorage.readToken();
        emit(SuccessAuthState(user, token?.accessToken??''));
      } else {
        emit(LogOutAuthState());
      }
    } catch (e) {
      emit(LogOutAuthState());
    }
  }

  Future<void> _onLogOut(LogOutEvent event, Emitter<AuthState> emit) async {
    await secureStorage.deleteSecureStorage();
    emit(LogOutAuthState());
    // emit(const AuthState());
  }}
