part of 'result_details_data_cubit.dart';

class ResultDetailsDataState extends Equatable {
  final bool isLoading;
  final bool isError;
  final bool isSuccess;
  final ResultDetailsDataModel? resultDetailsDataModel;

  const ResultDetailsDataState({
    this.isLoading = false,
    this.isError = false,
    this.isSuccess = false,
    this.resultDetailsDataModel,
  });

//copyWith
  ResultDetailsDataState copyWith({
    bool? isLoading,
    bool? isError,
    bool? isSuccess,
    ResultDetailsDataModel? resultDetailsDataModel,
  }) {
    return ResultDetailsDataState(
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      isSuccess: isSuccess ?? this.isSuccess,
      resultDetailsDataModel:
          resultDetailsDataModel ?? this.resultDetailsDataModel,
    );
  }

  @override
  List<Object> get props =>
      [isLoading, isError, resultDetailsDataModel ?? {}, isSuccess];
}
