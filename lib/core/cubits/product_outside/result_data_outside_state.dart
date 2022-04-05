part of 'result_data_outside_cubit.dart';

class ResultOutsideState extends Equatable {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final ResultDataModel? resultDataModel;

  const ResultOutsideState({
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.resultDataModel,
  });

  //copy with
  ResultOutsideState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    ResultDataModel? resultDataModel,
  }) {
    return ResultOutsideState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      resultDataModel: resultDataModel ?? this.resultDataModel,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, isError, resultDataModel ?? {}, isSuccess];
}
