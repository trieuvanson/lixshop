import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../models/models.dart';
import '../../../repositories/repositories.dart';

part 'result_data_outside_state.dart';

class ResultOutsideCubit extends Cubit<ResultOutsideState> {
  ResultOutsideCubit() : super(const ResultOutsideState());

  void getProductOutside() async {
    emit(ResultOutsideState.loading());
    //delay
    try {
      final resultDataModel = await resultDataRepository.getResultData();
      if (resultDataModel.productOutsideCategory!.isEmpty) {
        emit(state.copyWith(isLoading: false, isError: true));
      } else {
        emit(ResultOutsideState.loaded(resultDataModel));
      }
    } catch (e) {
      print('error: $e');
      emit(ResultOutsideState.error());
    }
  }
}
