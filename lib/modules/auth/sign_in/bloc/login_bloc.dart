import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';
import 'package:patidar_melap_app/modules/auth/sign_in/model/login_reponse.dart';
import 'package:patidar_melap_app/modules/auth/sign_in/model/login_request.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({required IAuthRepository repository})
      : _authRepository = repository,
        super(LoginInitial()) {
    on<MakeLoginEvent>(_performSignIn);
  }

  bool passwordVisible = false;

  final IAuthRepository _authRepository;
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  Future<Unit> _performSignIn(MakeLoginEvent event, Emitter<LoginState> emit) async {
    emit(
      const LoginState(
        status: ApiStatus.loading,
      ),
    );

    final signUpEither = await _authRepository
        .login(
          request: event.logInRequest,
        )
        .run();
    signUpEither.fold(
      (failure) => emit(
        LoginState(
          errorMsg: failure.message,
          status: ApiStatus.error,
        ),
      ),
      (success) async {
        emit(
          const LoginState(
            status: ApiStatus.loaded,
          ),
        );
      },
    );
    return unit;
  }
}
