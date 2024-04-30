part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class MakeLoginEvent extends LoginEvent {
  MakeLoginEvent(this.logInRequest);

  final LogInRequest logInRequest;
}
