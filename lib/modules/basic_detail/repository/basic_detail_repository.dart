import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patidar_melap_app/app/config/api_config.dart';
import 'package:patidar_melap_app/app/config/app_constants.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/core/data/repository-utils/repository_utils.dart';
import 'package:patidar_melap_app/core/domain/failure.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/response/caste_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/response/salary_response.dart';

abstract interface class IBasicDetailRepository {
  TaskEither<Failure, SalaryModel> fetchSalaryData();

  TaskEither<Failure, CasteModel> fetchCasteData();
}

class BasicDetailRepository implements IBasicDetailRepository {
  ///Caste Data
  @override
  TaskEither<Failure, CasteModel> fetchCasteData() => mappingCasteRequest();

  TaskEither<Failure, CasteModel> mappingCasteRequest() =>
      makeCasteRequest().chainEither(RepositoryUtils.checkStatusCode).chainEither(
            (response) => RepositoryUtils.mapToModel<CasteModel>(
              () => CasteModel.fromJson(response.data),
            ),
          );

  TaskEither<Failure, Response> makeCasteRequest() {
    return ApiClient.request(
      path: ApiConstants.caste,
      requestType: RequestType.get,
      queryParameters: {
        'limit': '-1',
      },
    );
  }

  //Salary Currency Data
  @override
  TaskEither<Failure, SalaryModel> fetchSalaryData() => mappingSalaryRequest();

  TaskEither<Failure, SalaryModel> mappingSalaryRequest() =>
      makeSalaryRequest().chainEither(RepositoryUtils.checkStatusCode).chainEither(
            (response) => RepositoryUtils.mapToModel<SalaryModel>(
              () => SalaryModel.fromJson(jsonDecode(response.data.toString())),
            ),
          );

  TaskEither<Failure, Response> makeSalaryRequest() {
    return ApiClient.request(
      path: ApiConstants.salaryCurrency,
      requestType: RequestType.get,
    );
  }
}
