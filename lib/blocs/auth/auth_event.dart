part of 'auth_bloc.dart';

abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final Login login;

  LoginEvent(this.login);
}

class CheckLoginEvent extends AuthEvent {}

class LogOutEvent extends AuthEvent {}
