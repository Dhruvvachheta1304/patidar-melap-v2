import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patidar_melap_app/modules/auth/log_out/logout_state.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';

class LogoutBloc extends Cubit<LogoutState> {
  LogoutBloc({
    required this.authenticationRepository,
  }) : super(const LogoutState.initial());

  final IAuthRepository authenticationRepository;

  FutureOr<void> logoutEvent() async {
    emit(const LogoutState.loading());

    final logoutEither = await authenticationRepository.logoutData().run();

    logoutEither.fold(
      (error) => LogoutState.error(error.message),
      (success) {
        authenticationRepository.logout();
        emit(const LogoutState.loaded('message'));
      },
    );
  }
}
