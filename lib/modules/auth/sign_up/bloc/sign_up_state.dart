part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SendOtpState extends SignUpState {
  SendOtpState({
    this.status = ApiStatus.initial,
    this.errorMsg,
    this.responseModel,
  });

  final ApiStatus status;
  final String? errorMsg;
  final SendOtpRequest? responseModel;
}

class RegisterState extends SignUpState {
  RegisterState({
    this.responseModel,
    this.errorMsg,
    this.status = ApiStatus.initial,
  });

  final ApiStatus status;
  final String? errorMsg;
  final SignUpRequest? responseModel;
}
