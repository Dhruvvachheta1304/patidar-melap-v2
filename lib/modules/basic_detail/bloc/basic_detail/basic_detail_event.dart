part of 'basic_detail_bloc.dart';

@immutable
sealed class BasicDetailEvent {}

class SubmitBasicDetailEvent extends BasicDetailEvent {
  SubmitBasicDetailEvent({required this.basicDetailResponse});

  final BasicDetailResponse basicDetailResponse;
}
