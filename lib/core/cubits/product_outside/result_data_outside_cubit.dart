import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/models1/models.dart';
import 'package:lixshop/repositories/product_outside_repositories/result_data_repository.dart';

part 'result_data_outside_state.dart';

class ResultOutsideCubit extends Cubit<ResultOutsideState> {
  ResultOutsideCubit() : super(const ResultOutsideState());
  void getProductOutside() async {
    emit(state.copyWith(isLoading: true));
    try {
      final resultDataModel = await resultDataRepository.getResultData();
      if (resultDataModel.productOutsideCategory!.isEmpty) {
        emit(state.copyWith(isLoading: false, isError: true));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          resultDataModel: resultDataModel,
        ));
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, isError: true, isSuccess: false));
    }
  }
}
