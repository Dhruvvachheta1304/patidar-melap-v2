import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';

class LoginFormBloc extends FormBloc<String, String> {
  LoginFormBloc({required IAuthRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository {
    addFieldBlocs(fieldBlocs: [email, password]);

    ///Custom validation for password character length check
    password
      ..addValidators([
        passwordMin8Chars(password),
      ])
      ..subscribeToFieldBlocs([password]);
  }
  final IAuthRepository _authenticationRepository;

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  ///Custom validation for password character length check
  Validator<String> passwordMin8Chars(
    TextFieldBloc passwordTextFieldBloc,
  ) {
    return (String? password) {
      if (password == null || password.isEmpty || password.runes.length >= 8) {
        return null;
      }
      return LocaleKeys.password_must_be_8_char.tr();
    };
  }

  @override
  FutureOr<void> onSubmitting() async {
    await Future<void>.delayed(const Duration(seconds: 3));

    final loginEither = await _authenticationRepository
        .login(
          email.value,
          password.value,
        )
        .run();
    loginEither.fold(
      (failure) => emitFailure(),
      (success) => emitSuccess(),
    );
  }
}
