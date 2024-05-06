part of 'caste_bloc.dart';

@immutable
abstract class CasteState {
  const CasteState();
}

class FetchCasteState extends CasteState {
  const FetchCasteState({this.status = ApiStatus.initial, this.errorMsg, this.responseModel});

  final ApiStatus status;
  final String? errorMsg;
  final CasteModel? responseModel;
}
