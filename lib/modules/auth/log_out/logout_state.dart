import 'package:equatable/equatable.dart';
import 'package:patidar_melap_app/app/enum.dart';

class LogoutState extends Equatable {
  const LogoutState.error(String message)
      : this._(
          status: ApiStatus.error,
          message: message,
        );

  const LogoutState.loaded(String message)
      : this._(
          status: ApiStatus.loaded,
          message: message,
        );

  const LogoutState._({
    this.message = '',
    this.status = ApiStatus.initial,
  });

  const LogoutState.loading() : this._(status: ApiStatus.loading);

  const LogoutState.initial() : this._(status: ApiStatus.initial);
  final String message;
  final ApiStatus status;

  @override
  List<Object?> get props => [message, status];

  @override
  bool get stringify => true;
}
