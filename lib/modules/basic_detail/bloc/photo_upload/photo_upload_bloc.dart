import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/request/photo_upload_request.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/response/photo_upload_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/repository/basic_detail_repository.dart';

part 'photo_upload_event.dart';
part 'photo_upload_state.dart';

class PhotoUploadBloc extends Bloc<PhotoUploadEvent, PhotoUploadState> {
  PhotoUploadBloc({required IBasicDetailRepository repository})
      : _basicDetailRepository = repository,
        super(PhotoUploadInitial()) {
    on<MakePhotoUploadEvent>(_photoUpload);
  }

  final IBasicDetailRepository _basicDetailRepository;

  Future<Unit> _photoUpload(MakePhotoUploadEvent event, Emitter<PhotoUploadState> emit) async {
    log('event.selectedImage: ${event.selectedImage}');

    // final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    event.selectedImage = File(event.selectedImage?.path ?? '');

    final imageFormData = FormData.fromMap({
      'profile_photos': await MultipartFile.fromFile(
        event.selectedImage?.path ?? '',
        filename: event.selectedImage?.path.split('/').last,
        // contentType: MediaType(mimee, type),
      ),
      'user_agent': 'NI-AAPP',
    });

    emit(
      const PhotoUploadState(
        status: ApiStatus.loading,
      ),
    );

    final photoUploadEither = await _basicDetailRepository.photoUpload(formData: imageFormData).run();

    photoUploadEither.fold(
      (failure) => emit(
        PhotoUploadState(
          errorMsg: failure.message,
          status: ApiStatus.error,
        ),
      ),
      (success) async {
        emit(
          PhotoUploadState(
            responseModel: success,
            status: ApiStatus.loaded,
          ),
        );
      },
    );
    return unit;
  }
}
