import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patidar_melap_app/app/config/api_config.dart';
import 'package:patidar_melap_app/app/config/app_constants.dart';
import 'package:patidar_melap_app/app/helpers/injection.dart';
import 'package:patidar_melap_app/core/data/models/user_model.dart';
import 'package:patidar_melap_app/core/data/repository-utils/repository_utils.dart';
import 'package:patidar_melap_app/core/data/services/auth.service.dart';
import 'package:patidar_melap_app/core/domain/failure.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/send_otp_request.dart';

/// This repository contains the contract for login and logout function
abstract interface class IAuthRepository {
  TaskEither<Failure, Unit> login(String email, String password);

  TaskEither<Failure, SendOtpRequest> sendOtp({required SendOtpRequest request});

  Future<bool> logout();
}

/// This class contains the implementation for login and logout functions.
/// This repository connects with [IAuthService] for setting the data of the user
/// that is given by the API Response
class AuthRepository implements IAuthRepository {
  AuthRepository();

  @override
  TaskEither<Failure, Unit> login(
    String email,
    String password,
  ) {
    final userModel = UserModel(
      name: 'cavin',
      email: 'demo@gmail.com',
      id: 1,
      profilePicUrl: 'profilePicUrl',
    );
    return getIt<IAuthService>().setAccessToken('uniquetoken').flatMap((_) => getIt<IAuthService>().setUserData(userModel));
  }

  @override
  Future<bool> logout() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 2));

      //clear auth tokens from the local storage
      await getIt<IAuthService>().clearData().run();
      return true;
    } catch (error) {
      log(error.toString());
      return false;
    }
  }

  @override
  TaskEither<Failure, SendOtpRequest> sendOtp({required SendOtpRequest request}) => mappingSendOtpRequest(request: request);

  TaskEither<Failure, SendOtpRequest> mappingSendOtpRequest({
    required SendOtpRequest request,
  }) =>
      makeSendOtpRequest(request: request).chainEither(RepositoryUtils.checkStatusCode).chainEither(
            (response) => RepositoryUtils.mapToModel<SendOtpRequest>(
              () => SendOtpRequest.fromJson(response.data),
            ),
          );

  TaskEither<Failure, Response> makeSendOtpRequest({
    required SendOtpRequest request,
  }) {
    return ApiClient.request(
      path: ApiConstants.sendOtp,
      body: request.toJson(),
    );
  }
}
