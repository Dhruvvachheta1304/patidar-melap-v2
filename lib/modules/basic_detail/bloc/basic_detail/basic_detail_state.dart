part of 'basic_detail_bloc.dart';

@immutable
sealed class BasicDetailState {}

final class BasicDetailInitial extends BasicDetailState {}

class SubmitBasicDetailState extends BasicDetailState {
  SubmitBasicDetailState({
    this.responseModel,
    this.errorMsg,
    this.status = ApiStatus.initial,
  });

  final ApiStatus status;
  final String? errorMsg;
  final BasicDetailResponse? responseModel;
}
