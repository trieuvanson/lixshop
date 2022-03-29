part of 'auth_bloc.dart';

class AuthState {
  const AuthState();
}

class LoadingAuthState extends AuthState {}

class SuccessAuthState extends AuthState {
  final AuthUser user;
  final String token;

  SuccessAuthState(this.user, this.token);
}

class LogOutAuthState extends AuthState {}

class FailureAuthState extends AuthState {
  final error;

  FailureAuthState(this.error);
}
