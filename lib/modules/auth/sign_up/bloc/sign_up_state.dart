part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class MakeSignUpState extends SignUpState {
  MakeSignUpState({
    this.status = ApiStatus.initial,
    this.errorMsg,
    this.responseModel,
  });

  final ApiStatus status;
  final String? errorMsg;
  final SendOtpRequest? responseModel;
}
