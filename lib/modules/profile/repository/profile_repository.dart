import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patidar_melap_app/app/config/api_config.dart';
import 'package:patidar_melap_app/app/config/app_constants.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/core/data/repository-utils/repository_utils.dart';
import 'package:patidar_melap_app/core/domain/failure.dart';
import 'package:patidar_melap_app/modules/profile/model/response/me_response.dart';

abstract interface class IProfileRepository {
  TaskEither<Failure, UserDataModel> fetchProfile();
}

class ProfileRepository implements IProfileRepository {
  ProfileRepository();

  @override
  TaskEither<Failure, UserDataModel> fetchProfile() => mappingFetchProfileRequest();

  TaskEither<Failure, UserDataModel> mappingFetchProfileRequest() =>
      makeFetchProfileRequest().chainEither(RepositoryUtils.checkStatusCode).chainEither(
            (response) => RepositoryUtils.mapToModel<UserDataModel>(
              () => UserDataModel.fromJson(jsonDecode(response.data.toString())),
            ),
          );

  TaskEither<Failure, Response> makeFetchProfileRequest() {
    return ApiClient.request(
      path: ApiConstants.me,
      requestType: RequestType.get,
      queryParameters: {
        'user_agent': 'NI-AAPP',
      },
    );
  }

// TaskEither<Failure, UserDataModel> saveDataToLocal(UserDataModel data) {
//   if (data.status != null) {
//     final updatedModel = UserDataModel(
//       familyDetailCompleted: data.familyDetailCompleted ?? false,
//       basicDetailCompleted: data.basicDetailCompleted ?? false,
//       otherDetailCompleted: data.otherDetailCompleted ?? false,
//       photosCompleted: data.photosCompleted ?? false,
//     );
//     getIt<IAuthService>().setUserData(updatedModel).run();
//
//     return TaskEither.right(data);
//   } else {
//     return TaskEither.left(APIFailure(error: LocaleKeys.field_required.tr()));
//   }
// }
}
