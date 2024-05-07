import 'dart:convert';
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
import 'package:patidar_melap_app/modules/auth/sign_in/model/login_reponse.dart';
import 'package:patidar_melap_app/modules/auth/sign_in/model/login_request.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/send_otp_request.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/sign_up_request.dart';

/// This repository contains the contract for login and logout function
abstract interface class IAuthRepository {
  TaskEither<Failure, LoginResponse> login({required LogInRequest request});

  TaskEither<Failure, SignUpRequest> register({required SignUpRequest request});

  TaskEither<Failure, SendOtpRequest> sendOtp({required SendOtpRequest request});

  Future<bool> logout();
}

/// This class contains the implementation for login and logout functions.
/// This repository connects with [IAuthService] for setting the data of the user
/// that is given by the API Response
class AuthRepository implements IAuthRepository {
  AuthRepository();

  final _authService = getIt<IAuthService>();

  @override
  TaskEither<Failure, LoginResponse> login({required LogInRequest request}) => mappingLoginRequest(request: request);

  TaskEither<Failure, LoginResponse> mappingLoginRequest({required LogInRequest request}) => makeLoginRequest(request: request)
      .chainEither(RepositoryUtils.checkStatusCode)
      .chainEither(
        (response) => RepositoryUtils.mapToModel<LoginResponse>(
          () => LoginResponse.fromJson(
            jsonDecode(response.toString()) as Map<String, dynamic>,
          ),
        ),
      )
      .flatMap(saveTokenToLocal);

  TaskEither<Failure, LoginResponse> saveTokenToLocal(LoginResponse loginResponseModel) {
    if (loginResponseModel.token != null) {
      ApiClient.setAuthorizationToken(loginResponseModel.token!);
      final updatedModel = UserModel(
        name: loginResponseModel.userData?.username ?? '',
        email: loginResponseModel.userData?.email ?? '',
        id: loginResponseModel.userData?.id ?? '',
        profilePicUrl: '',
      );
      _authService.setUserData(updatedModel).run();
      _authService.setAccessToken(loginResponseModel.token!);
      return TaskEither.right(loginResponseModel);
    } else {
      return TaskEither.left(
        APIFailure(error: loginResponseModel),
      );
    }
  }

  TaskEither<Failure, Response> makeLoginRequest({required LogInRequest request}) {
    return ApiClient.request(
      path: ApiConstants.login,
      body: FormData.fromMap(
        request.toJSON(),
      ),
    );
  }

  @override
  TaskEither<Failure, SignUpRequest> register({required SignUpRequest request}) => mappingRegisterRequest(
        request: request,
      );

  TaskEither<Failure, SignUpRequest> mappingRegisterRequest({
    required SignUpRequest request,
  }) =>
      makeRegisterRequest(request: request).chainEither(RepositoryUtils.checkStatusCode).chainEither(
            (response) => RepositoryUtils.mapToModel<SignUpRequest>(
              () => SignUpRequest.fromJson(
                jsonDecode(
                  response.data.toString(),
                ),
              ),
            ),
          );

  TaskEither<Failure, Response> makeRegisterRequest({
    required SignUpRequest request,
  }) {
    return ApiClient.request(
      path: ApiConstants.register,
      body: FormData.fromMap(request.toJson()),
      // body: request.toJson(),
    );
  }

  @override
  TaskEither<Failure, SendOtpRequest> sendOtp({required SendOtpRequest request}) => mappingSendOtpRequest(
        request: request,
      );

  TaskEither<Failure, SendOtpRequest> mappingSendOtpRequest({
    required SendOtpRequest request,
  }) =>
      makeSendOtpRequest(request: request).chainEither(RepositoryUtils.checkStatusCode).chainEither(
            (response) => RepositoryUtils.mapToModel<SendOtpRequest>(
              () => SendOtpRequest.fromJson(
                jsonDecode(
                  response.data.toString(),
                ),
              ),
            ),
          );

  TaskEither<Failure, Response> makeSendOtpRequest({
    required SendOtpRequest request,
  }) {
    return ApiClient.request(
      path: ApiConstants.sendOtp,
      body: FormData.fromMap(request.toJson()),
    );
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
}
