import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/send_otp_request.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/sign_up_request.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required IAuthRepository repository,
  })  : _authRepository = repository,
        super(SignUpInitial()) {
    on<SendOtpEvent>(_sendOtp);
    on<RegisterEvent>(_register);
  }

  bool passwordVisible = false;

  final IAuthRepository _authRepository;

  final formKey = GlobalKey<FormState>();
  final otpFormKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passWordController = TextEditingController();
  final userNameController = TextEditingController();
  final otpController = TextEditingController();

  Future<Unit> _sendOtp(SendOtpEvent event, Emitter<SignUpState> emit) async {
    emit(
      MakeSignUpState(
        status: ApiStatus.loading,
      ),
    );

    final signUpEither = await _authRepository.sendOtp(request: event.sendOtpRequest).run();

    signUpEither.fold(
      (failure) => emit(
        MakeSignUpState(
          errorMsg: failure.message,
          status: ApiStatus.error,
        ),
      ),
      (success) async {
        emit(
          MakeSignUpState(
            responseModel: success,
            status: ApiStatus.loaded,
          ),
        );
      },
    );
    return unit;
  }

  Future<Unit> _register(RegisterEvent event, Emitter<SignUpState> emit) async {
    emit(MakeRegisterState(status: ApiStatus.loading));

    final registerEither = await _authRepository.register(request: event.signUpRequest).run();

    registerEither.fold(
      (failure) => emit(
        MakeRegisterState(
          errorMsg: failure.message,
          status: ApiStatus.error,
        ),
      ),
      (success) async {
        emit(
          MakeRegisterState(
            responseModel: success,
            status: ApiStatus.loaded,
          ),
        );
      },
    );
    return unit;
  }
}
