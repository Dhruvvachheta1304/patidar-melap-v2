import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/modules/profile/model/response/me_response.dart';
import 'package:patidar_melap_app/modules/profile/repository/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, FetchProfileState> {
  ProfileBloc({
    required IProfileRepository repository,
    // required IAuthRepository authRepository,
  })  : _profileRepository = repository,
        // _authRepository = authRepository,
        super(FetchProfileState()) {
    // on<ProfileEvent>((event, emit) {});
    on<FetchProfileEvent>(_fetchMyProfile);
  }

  final IProfileRepository _profileRepository;

  // final IAuthRepository _authRepository;

  String? selectedImage;
  List<Photos>? photos;

  Future<Unit> _fetchMyProfile(FetchProfileEvent event, Emitter<ProfileState> emit) async {
    emit(
      FetchProfileState(
        status: ApiStatus.loading,
      ),
    );

    final fetchProfileEither = await _profileRepository.fetchProfile().run();

    await fetchProfileEither.fold(
      (failure) {
        emit(
          FetchProfileState(
            status: ApiStatus.error,
            errorMsg: failure.message,
          ),
        );
      },
      (success) async {
        selectedImage = success.basicDetail?.profilePhotoUrl;
        emit(
          FetchProfileState(
            responseModel: success,
            status: ApiStatus.loaded,
          ),
        );
      },
    );
    return unit;
  }
}
