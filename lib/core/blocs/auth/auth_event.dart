part of 'auth_bloc.dart';

abstract class AuthEvent {}

class AuthLoggedEvent extends AuthEvent {
  final Login login;

  AuthLoggedEvent(this.login);
}

class CheckLoginEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}
