part of 'result_data_outside_cubit.dart';

 class ResultOutsideState extends Equatable {
  final bool isLoading;
  final ResultDataModel? resultDataModel;
  final bool isError;

  const ResultOutsideState({
    this.isLoading = false,
    this.resultDataModel,
    this.isError = false,
  });

  //copy with
  ResultOutsideState copyWith({
    bool? isLoading,
    ResultDataModel? resultDataModel,
    bool? isError,
  }) {
    return ResultOutsideState(
      isLoading: isLoading ?? this.isLoading,
      resultDataModel: resultDataModel ?? this.resultDataModel,
      isError: isError ?? this.isError,
    );
  }

  @override
  List<Object> get props => [isLoading, resultDataModel??{}, isError];
}


