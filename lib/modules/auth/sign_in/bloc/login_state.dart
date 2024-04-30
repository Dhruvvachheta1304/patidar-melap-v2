part of 'login_bloc.dart';

class LoginState {
  const LoginState({
    this.status = ApiStatus.initial,
    this.errorMsg,
    this.responseModel,
  });

  final ApiStatus status;
  final String? errorMsg;
  final LoginResponse? responseModel;
}

final class LoginInitial extends LoginState {}
