import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/models/models.dart';

import '../../../repositories/repositories.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(LoadingUserState()) {
    on<UserEventRegister>(_register);
  }

  void _register(UserEventRegister event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());
      await Future.delayed(const Duration(seconds: 1));
      final response = await userRepository.register(event.register);
      print(response);
      if (response.err == 0) {
        emit(UserSuccessState(message: response.msg!));
      } else {
        emit(UserErrorState(error: response.msg!));
      }
    } catch (e) {
      emit(const UserErrorState(error: "Có lỗi xảy ra"));
    }
  }

}
