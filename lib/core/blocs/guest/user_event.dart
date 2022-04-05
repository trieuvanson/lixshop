part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class UserEventFetch extends UserEvent {
  final AuthUser? user;

  const UserEventFetch({this.user});

  @override
  List<Object> get props => [user!];
}

class UserEventRegister extends UserEvent {
  final Register register;

  const UserEventRegister({required this.register});

  @override
  List<Object> get props => [register];
}
