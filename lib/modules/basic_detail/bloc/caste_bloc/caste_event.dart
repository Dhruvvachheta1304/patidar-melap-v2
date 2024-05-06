part of 'caste_bloc.dart';

@immutable
sealed class CasteEvent extends Equatable {
  const CasteEvent();

  @override
  List<Object?> get props => [];
}

class FetchCasteDataEvent extends CasteEvent {
  const FetchCasteDataEvent(// required this.couponDataRequest,
      // this.isRefresh = false,
      );
}
