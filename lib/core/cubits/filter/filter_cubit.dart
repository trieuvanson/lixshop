import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lixshop/models/filters/category_filter.dart';

part 'filter_state.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState.initial());

  String get getKeyword => state.keyword!;

  List<CategoryFilter> get getCategory => state.categoryFilters!;

  void setKeyword(String keyword) {
    emit(state.copyWith(keyword: keyword));
  }

  void setCategory(List<CategoryFilter> categoryFilters) {
    emit(state.copyWith(categoryFilters: categoryFilters));
  }
}
