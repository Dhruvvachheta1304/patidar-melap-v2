import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:meta/meta.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/response/salary_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/repository/basic_detail_repository.dart';

part 'salary_event.dart';
part 'salary_state.dart';

class SalaryBloc extends Bloc<SalaryEvent, SalaryState> {
  SalaryBloc({
    required IBasicDetailRepository repository,
  })  : _basicDetailRepository = repository,
        super(const FetchSalaryState()) {
    on<FetchSalaryEvent>(_fetchSalaryData);
  }

  final IBasicDetailRepository _basicDetailRepository;

  String? salaryId;
  String? currencyId;

  Future<Unit> _fetchSalaryData(FetchSalaryEvent event, Emitter<SalaryState> emit) async {
    emit(
      const FetchSalaryState(
        status: ApiStatus.loading,
      ),
    );

    final salaryEither = await _basicDetailRepository.fetchSalaryData().run();

    salaryEither.fold(
      (failure) => emit(
        FetchSalaryState(
          status: ApiStatus.error,
          errorMsg: failure.message,
        ),
      ),
      (success) async {
        emit(FetchSalaryState(
          status: ApiStatus.loaded,
          responseModel: success,
        ));
      },
    );
    return unit;
  }
}
