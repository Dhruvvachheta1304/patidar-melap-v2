import 'package:bloc/bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/basic_detail_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/repository/basic_detail_repository.dart';

part 'basic_detail_event.dart';
part 'basic_detail_state.dart';

class BasicDetailBloc extends Bloc<SubmitBasicDetailEvent, BasicDetailState> {
  BasicDetailBloc({
    required BasicDetailRepository repository,
  })  : _basicDetailRepository = repository,
        super(BasicDetailInitial()) {
    on<SubmitBasicDetailEvent>(_updateDetails);
  }

  final IBasicDetailRepository _basicDetailRepository;

//
  Future<Unit> _updateDetails(SubmitBasicDetailEvent event, Emitter<BasicDetailState> emit) async {
    emit(
      SubmitBasicDetailState(
        status: ApiStatus.loading,
      ),
    );

    final updateDetailEither = await _basicDetailRepository.updateDetail(request: event.basicDetailResponse).run();

    updateDetailEither.fold(
        (failure) => emit(SubmitBasicDetailState(
              errorMsg: failure.message,
              status: ApiStatus.error,
            )), (success) async {
      emit(
        SubmitBasicDetailState(
          responseModel: success,
          status: ApiStatus.loaded,
        ),
      );
    });
    return unit;
  }
}
