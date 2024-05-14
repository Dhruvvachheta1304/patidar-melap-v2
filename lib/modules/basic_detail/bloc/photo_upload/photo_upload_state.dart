part of 'photo_upload_bloc.dart';

@immutable
class PhotoUploadState {
  const PhotoUploadState({
    this.status = ApiStatus.initial,
    this.errorMsg,
    this.responseModel,
  });

  final ApiStatus status;
  final String? errorMsg;
  final PhotoUploadResponse? responseModel;
}

final class PhotoUploadInitial extends PhotoUploadState {}
