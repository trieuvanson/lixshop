import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/models.dart';

part 'product_categories_outside_state.dart';

class CategoryDataOutsideCubit extends Cubit<CategoryDataOutsideState> {
  CategoryDataOutsideCubit() : super(const CategoryDataOutsideState());

  Future<void> getByResult(ResultDataModel resultData) async {
    emit(const CategoryDataOutsideState.loading());
    try {
      final categories = resultData.productOutsideCategory;
      emit(CategoryDataOutsideState.loaded(categories));
    } catch (e) {
      emit(const CategoryDataOutsideState.error());
    }
  }
}
