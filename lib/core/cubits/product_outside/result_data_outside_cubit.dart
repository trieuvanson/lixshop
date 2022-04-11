import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'result_data_outside_state.dart';

class ResultOutsideCubit extends Cubit<ResultOutsideState> {
  ResultOutsideCubit() : super(const ResultOutsideState());
  void getProductOutside() async {
    emit(state.copyWith(isLoading: true));
    try {
      final resultDataModel = await resultDataRepository.getResultData();
      print(resultDataModel.productOutsideCategory!.length);
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
      print('error: $e');
      emit(state.copyWith(isLoading: false, isError: true, isSuccess: false));
    }
  }
}
