part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class LoadingUserState extends UserState {
  @override
  List<Object> get props => [];
}

class UserSuccessState extends UserState {
  final String message;

  const UserSuccessState({this.message = "Thành công"});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class UserErrorState extends UserState {
  final String error;

  const UserErrorState({this.error = "Lỗi"});

  @override
  List<Object> get props => [error];
}
