part of 'product_categories_outside_cubit.dart';

class CategoryDataOutsideState extends Equatable {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final List<ProductOutsideCategory>? categories;

  const CategoryDataOutsideState({
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.categories = const [],
  });

  const CategoryDataOutsideState.loading() : this(isLoading: true, isError: false, isSuccess: false);

  const CategoryDataOutsideState.error() : this(isError: true, isLoading: false, isSuccess: false);

  const CategoryDataOutsideState.loaded(final list) : this(categories: list, isLoading: false, isError: false, isSuccess: true);

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
