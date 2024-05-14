part of 'photo_upload_bloc.dart';

@immutable
sealed class PhotoUploadEvent {}

class MakePhotoUploadEvent extends PhotoUploadEvent {
  MakePhotoUploadEvent(
    this.photoUploadRequest,
    this.selectedImage,
  );

  final PhotoUploadRequest photoUploadRequest;
  File? selectedImage;
}

class SelectedImageEvent extends PhotoUploadEvent {
  SelectedImageEvent(this.selectedImage);

  final File? selectedImage;
}
