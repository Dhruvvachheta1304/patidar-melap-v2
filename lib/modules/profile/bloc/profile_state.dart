part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class FetchProfileState extends ProfileState {
  FetchProfileState({
    this.status = ApiStatus.initial,
    this.errorMsg,
    this.responseModel,
  });

  final ApiStatus status;
  final String? errorMsg;
  final UserDataModel? responseModel;
}

final class UserDataInitial extends ProfileState {}
