import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:lixshop/models/models.dart';

import '../../../repositories/repositories.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(LoadingUserState()) {
    on<UserEventRegister>(_register);
    on<UserEventDisable>(_disableUser);
  }

  void _register(UserEventRegister event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());
      final response = await userRepository.register(event.register);
      if (kDebugMode) {
        print(response);
      }
      if (response.err == 0) {
        emit(UserSuccessState(message: response.msg!));
      } else {
        emit(UserErrorState(error: response.msg!));
      }
    } catch (e) {
      emit(const UserErrorState(error: "Có lỗi xảy ra"));
    }
  }


  void _disableUser(UserEventDisable event, Emitter<UserState> emit) async {
    try {
      emit(LoadingUserState());
      final response = await userRepository.disableUser(event.password);
      if (kDebugMode) {
        print(response);
      }
      if (response['err'] == 0) {
        emit(UserSuccessState(message: response['msg']));
        await authRepository.signOut();
      } else {
        emit(UserErrorState(error: response['msg']));
      }
    } catch (e) {
      emit(const UserErrorState(error: "Có lỗi xảy ra"));
    }
  }
}
