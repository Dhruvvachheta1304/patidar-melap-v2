import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/response/caste_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/repository/basic_detail_repository.dart';

part 'caste_event.dart';
part 'caste_state.dart';

class CasteBloc extends Bloc<CasteEvent, CasteState> {
  CasteBloc({
    required IBasicDetailRepository repository,
  })  : _basicDetailRepository = repository,
        super(const FetchCasteState()) {
    on<FetchCasteDataEvent>(_fetchCasteData);
  }

  final IBasicDetailRepository _basicDetailRepository;

  String? casteId;
  String? subCasteId;
  int? sataPetaId;
  String? selectedImagePath = '';
  File? selectedImage;

  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final sataPetaController = TextEditingController();
  final educationController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final timeOfBirthController = TextEditingController();
  final placeOfBirthController = TextEditingController();
  final maritalStatusController = TextEditingController();
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final occupationController = TextEditingController();
  final currencyController = TextEditingController();
  final salaryController = TextEditingController();

  Future<Unit> _fetchCasteData(FetchCasteDataEvent event, Emitter<CasteState> emit) async {
    emit(
      const FetchCasteState(
        status: ApiStatus.loading,
      ),
    );

    final casteEither = await _basicDetailRepository.fetchCasteData().run();

    casteEither.fold(
      (failure) => emit(
        FetchCasteState(
          status: ApiStatus.error,
          errorMsg: failure.message,
        ),
      ),
      (success) async {
        emit(
          FetchCasteState(
            status: ApiStatus.loaded,
            responseModel: success,
          ),
        );
      },
    );
    return unit;
  }
}
