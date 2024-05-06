part of 'salary_bloc.dart';

@immutable
abstract class SalaryState {
  const SalaryState();
}

class FetchSalaryState extends SalaryState {
  const FetchSalaryState({this.status = ApiStatus.initial, this.errorMsg, this.responseModel});

  final ApiStatus status;
  final String? errorMsg;
  final SalaryModel? responseModel;
}
