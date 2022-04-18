part of 'filter_cubit.dart';

class FilterState extends Equatable {
  final List<CategoryFilter>? categoryFilters;
  final String? keyword;

  const FilterState({
    this.categoryFilters = const [],
    this.keyword = "",
  });

  FilterState.initial() : this(categoryFilters: [], keyword: "");

  const FilterState.changeKeyword(String keyword) : this(keyword: keyword);

  const FilterState.changeCategoryFilters(List<CategoryFilter> categoryFilters)
      : this(categoryFilters: categoryFilters);

  FilterState copyWith({
    List<CategoryFilter>? categoryFilters,
    String? keyword,
  }) {
    return FilterState(
      categoryFilters: categoryFilters ?? this.categoryFilters,
      keyword: keyword ?? this.keyword,
    );
  }

  @override
  List<Object> get props => [categoryFilters ?? [], keyword ?? ''];
}
