part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SendOtpEvent extends SignUpEvent {
  SendOtpEvent({required this.sendOtpRequest});

  final SendOtpRequest sendOtpRequest;
}
