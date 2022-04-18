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


  //loading
  factory ResultOutsideState.loading() {
    return const ResultOutsideState(
      isLoading: true,
      isError: false,
      isSuccess: false,
      resultDataModel: null,
    );
  }

  //loaded
  factory ResultOutsideState.loaded(ResultDataModel resultDataModel) {
    return ResultOutsideState(
      isLoading: false,
      isError: false,
      isSuccess: true,
      resultDataModel: resultDataModel,
    );
  }

  //error
  factory ResultOutsideState.error() {
    return const ResultOutsideState(
      isLoading: false,
      isError: true,
      isSuccess: false,
      resultDataModel: null,
    );
  }
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
