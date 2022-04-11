import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';
import '../../../repositories/product_details_repositories/result_details_data_model.dart';

part 'result_details_data_state.dart';

class ResultDetailsDataCubit extends Cubit<ResultDetailsDataState> {
  ResultDetailsDataCubit() : super(const ResultDetailsDataState());

  void getProductOutside(int idBrand) async {
    emit(state.copyWith(isLoading: true));
    try {
      final resultDetailsDataModel = await resultDetailsDataRepository.getResultDetailsData(idBrand);
      print(resultDetailsDataModel.productSizesList!.length);
      if (resultDetailsDataModel.productSizesList!.isEmpty) {
        emit(state.copyWith(isLoading: false, isError: true));
      } else {
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          resultDetailsDataModel: resultDetailsDataModel,
        ));
      }
    } catch (e) {
      print('error: $e');
      emit(state.copyWith(isLoading: false, isError: true, isSuccess: false));
    }
  }


}
