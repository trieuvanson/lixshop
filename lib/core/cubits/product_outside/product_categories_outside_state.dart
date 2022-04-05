part of 'product_categories_outside_cubit.dart';

class CategoryDataOutsideState extends Equatable {
  final bool isLoading;
  final List<ProductOutsideCategory>? categories;
  final bool isError;

  const CategoryDataOutsideState({
    this.isLoading = false,
    this.categories = const [],
    this.isError = false,
  });

  const CategoryDataOutsideState.loading() : this(isLoading: true);

  const CategoryDataOutsideState.error() : this(isError: true);

  const CategoryDataOutsideState.loaded(final list) : this(categories: list);

  //copyWith
  CategoryDataOutsideState copyWith({
    final bool? isLoading,
    final List<ProductOutsideCategory>? categories,
    final bool? isError,
  }) =>
      CategoryDataOutsideState(
        isLoading: isLoading ?? this.isLoading,
        categories: categories ?? this.categories,
        isError: isError ?? this.isError,
      );

  @override
  List<Object?> get props => [
        isLoading,
        categories,
        isError,
      ];
}
