import 'dart:developer';
import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/helpers/validation_helper.dart';
import 'package:patidar_melap_app/app/theme/app_colors.dart';
import 'package:patidar_melap_app/app/theme/app_theme.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:patidar_melap_app/core/presentation/utils/app_utils.dart';
import 'package:patidar_melap_app/core/presentation/utils/date_time_utils.dart';
import 'package:patidar_melap_app/core/presentation/widgets/app_button.dart';
import 'package:patidar_melap_app/core/presentation/widgets/custom_text_field.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/basic_detail/bloc/basic_detail/basic_detail_bloc.dart';
import 'package:patidar_melap_app/modules/basic_detail/bloc/caste_bloc/caste_bloc.dart';
import 'package:patidar_melap_app/modules/basic_detail/bloc/photo_upload/photo_upload_bloc.dart';
import 'package:patidar_melap_app/modules/basic_detail/bloc/salary_bloc/salary_bloc.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/basic_detail_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/request/photo_upload_request.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/response/caste_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/model/response/salary_response.dart';
import 'package:patidar_melap_app/modules/basic_detail/repository/basic_detail_repository.dart';
import 'package:patidar_melap_app/modules/basic_detail/widgets/custom_info_box.dart';
import 'package:patidar_melap_app/modules/profile/bloc/profile_bloc.dart';
import 'package:patidar_melap_app/modules/profile/repository/profile_repository.dart';

@RoutePage()
class BasicDetailsScreen extends StatefulWidget implements AutoRouteWrapper {
  const BasicDetailsScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return RepositoryProvider<BasicDetailRepository>(
      create: (context) => BasicDetailRepository(),
      child: MultiBlocProvider(
        providers: [
          RepositoryProvider(
            create: (context) => ProfileRepository(),
          ),
          BlocProvider(
            lazy: false,
            create: (context) => CasteBloc(
              repository: context.read<BasicDetailRepository>(),
            )..add(const FetchCasteDataEvent()),
            child: this,
          ),
          BlocProvider(
            lazy: false,
            create: (context) => SalaryBloc(
              repository: context.read<BasicDetailRepository>(),
            )..add(const FetchSalaryEvent()),
            child: this,
          ),
          BlocProvider(
            lazy: false,
            create: (context) => SalaryBloc(
              repository: context.read<BasicDetailRepository>(),
            )..add(const FetchSalaryEvent()),
            child: this,
          ),
          BlocProvider(
            lazy: false,
            create: (context) => PhotoUploadBloc(
              repository: context.read<BasicDetailRepository>(),
            ),
            child: this,
          ),
          BlocProvider(
            lazy: false,
            create: (context) => BasicDetailBloc(
              repository: context.read<BasicDetailRepository>(),
            ),
            child: this,
          ),
          BlocProvider(
            lazy: false,
            create: (context) => ProfileBloc(
              repository: context.read<ProfileRepository>(),
              // RepositoryProvider.of<ProfileRepository>(context),
            )..add(FetchProfileEvent()),
            child: this,
          ),
        ],
        child: this,
      ),
    );
  }

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  late SalaryBloc salaryBloc;
  late CasteBloc casteBloc;
  late PhotoUploadBloc photoUploadBloc;
  late ProfileBloc profileBloc;
  late BasicDetailBloc basicDetailBloc;

  //caste
  List<CasteData>? casteList = [];

  //salary
  List<Salarylist>? salaryList = [];

  //currency
  List<Currencylist>? currencyList = [];

  List<String> subCasteList = ['Kadva', 'Leva'];
  List<String> genderList = ['Male', 'Female'];

  List<int> sataPeta = [0, 1];

  ///////////\\\\\\\\\\\
  TimeOfDay timeOfDay = TimeOfDay.now();

  @override
  void didChangeDependencies() {
    salaryBloc = context.read<SalaryBloc>();
    casteBloc = context.read<CasteBloc>();
    photoUploadBloc = context.read<PhotoUploadBloc>();
    profileBloc = context.read<ProfileBloc>();
    basicDetailBloc = context.read<BasicDetailBloc>();
    super.didChangeDependencies();
  }

  File? selectedImage;

  Future<void> pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      selectedImage = File(image?.path ?? '');

      setState(() {});
      await _photoUpload();
    } catch (e) {
      log('Error in picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.basic_details.tr(),
          style: TextStyle(
            fontSize: 16,
            color: context.colorScheme.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: const PreferredSize(preferredSize: Size.fromHeight(10), child: VSpace(5)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: context.colorScheme.grey100,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
      ),
      body: BlocConsumer<BasicDetailBloc, BasicDetailState>(
        listener: (context, state) {
          if (state is SubmitBasicDetailState && state.status == ApiStatus.loading) {}
          if (state is SubmitBasicDetailState && state.responseModel?.status == 'success') {
            AppUtils.showSnackBar(
              context,
              state.responseModel?.message,
              // isError: true,
            );
            context.maybePop();
          }
          if (state is SubmitBasicDetailState && state.responseModel?.status == 'error') {
            AppUtils.showSnackBar(
              context,
              state.responseModel?.message,
              // isError: true,
            );
          }
        },
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.only(left: Insets.medium, right: Insets.medium),
            children: [
              Form(
                key: casteBloc.formKey,
                child: Column(
                  children: [
                    VSpace.medium(),
                    Stack(
                      children: [
                        CircleAvatar(
                          minRadius: 80,
                          maxRadius: 80,
                          backgroundImage: selectedImage != null ? FileImage(selectedImage!) : null,
                        ),
                        Positioned(
                          bottom: Insets.xxsmall,
                          right: 0,
                          child: IconButton(
                            icon: ClipOval(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    Insets.xxxlarge,
                                  ),
                                  color: AppColors.white,
                                  border: Border.all(),
                                ),
                                padding: const EdgeInsets.all(
                                  Insets.xxsmall,
                                ),
                                child: const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: Insets.large,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            onPressed: pickImage,
                          ),
                        ),
                      ],
                    ),

                    VSpace.small(),
                    AppText.muktaVaani(
                      '${LocaleKeys.index_number.tr()} : A58506',
                      fontSize: 18,
                      color: context.colorScheme.black,
                      fontWeight: FontWeight.w600,
                    ),
                    VSpace.small(),
                    CustomInfoBox(
                      color: context.colorScheme.info,
                      widget: Column(
                        children: [
                          bulletPoint(
                            'Upload a passport size photograph or similar. Do not post photos of hobby glasses, hats or selfies.',
                          ),
                          bulletPoint('If this instruction is not followed your resume will be deleted.'),
                          bulletPoint('Girls can register even without uploading a photo.'),
                        ],
                      ),
                    ),
                    VSpace.small(),
                    Row(
                      children: [
                        Flexible(
                          child: CustomTextField(
                            controller: casteBloc.firstNameController,
                            titleDescription: AppText.muktaVaani(
                              LocaleKeys.first_name.tr(),
                              color: context.colorScheme.black,
                            ),
                            fillColor: context.colorScheme.grey100,
                            hintText: LocaleKeys.first_name.tr(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocaleKeys.common_msg_required_field.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                        const HSpace(7),
                        Flexible(
                          child: CustomTextField(
                            controller: casteBloc.lastNameController,
                            titleDescription: AppText.muktaVaani(
                              LocaleKeys.last_name.tr(),
                              color: context.colorScheme.black,
                            ),
                            fillColor: context.colorScheme.grey100,
                            hintText: LocaleKeys.last_name.tr(),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocaleKeys.common_msg_required_field.tr();
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    VSpace.small(),
                    Row(
                      children: [
                        Flexible(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: AppText.muktaVaani(
                                  LocaleKeys.caste.tr(),
                                  color: context.colorScheme.black,
                                ),
                              ),
                              VSpace.xsmall(),
                              BlocConsumer<CasteBloc, CasteState>(
                                listener: (context, state) {
                                  if (state is FetchCasteState && state.status == ApiStatus.loaded) {
                                    casteList = state.responseModel?.casteDataList;
                                    if (casteList?.isNotEmpty ?? false) {
                                      casteBloc.casteId = casteList?.first.id;
                                    }
                                  }
                                  if (state is FetchCasteState && state.status == ApiStatus.loaded) {
                                    // AppUtils.showSnackBar(
                                    //   context,
                                    //   '',
                                    // );
                                  }
                                  if (state is FetchCasteState && state.status == ApiStatus.error) {
                                    AppUtils.showSnackBar(
                                      context,
                                      state.errorMsg,
                                      isError: true,
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  if (casteList?.isNotEmpty ?? false) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        CustomDropdown<CasteData>(
                                          items: casteList ?? [],
                                          initialItem: casteList?.first,
                                          excludeSelected: false,
                                          onChanged: (value) {
                                            casteBloc.casteId = value.id;
                                          },
                                          decoration: CustomDropdownDecoration(
                                            overlayScrollbarDecoration: const ScrollbarThemeData(
                                              interactive: false,
                                            ),
                                            closedBorder: Border.all(
                                              color: context.colorScheme.textFieldFill,
                                            ),
                                            closedBorderRadius: const BorderRadius.all(
                                              Radius.circular(AppTheme.radius6),
                                            ),
                                            closedFillColor: context.colorScheme.grey100,
                                            expandedBorder: Border.all(
                                              color: context.colorScheme.textFieldFill,
                                            ),
                                            expandedBorderRadius: const BorderRadius.all(
                                              Radius.circular(AppTheme.radius6),
                                            ),
                                            expandedFillColor: context.colorScheme.textFieldFill,
                                          ),
                                          headerBuilder: (context, selectedItem) {
                                            return Text(
                                              selectedItem.casteName ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 14),
                                            );
                                          },
                                          listItemBuilder: (context, data, isSelected, onItemTap) {
                                            return Text(
                                              data.casteName ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(fontSize: 14),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }
                                  if (state is FetchCasteState &&
                                      state.status == ApiStatus.loaded &&
                                      (state.responseModel?.casteDataList?.isEmpty ?? true)) {
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppText.formLabel(
                                          context.tr(LocaleKeys.caste),
                                        ),
                                        VSpace.xsmall(),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            color: context.colorScheme.textFieldFill,
                                            borderRadius: BorderRadius.circular(AppTheme.radius6),
                                          ),
                                          child: AppText.formLabel(
                                            context.tr(LocaleKeys.no_data),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  if (state is FetchCasteState && state.status == ApiStatus.loading) {
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 15,
                                      ),
                                      decoration: BoxDecoration(
                                        color: context.colorScheme.textFieldFill,
                                        borderRadius: BorderRadius.circular(AppTheme.radius6),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 1,
                                              color: context.colorScheme.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                                  return const SizedBox.shrink();
                                },
                              ),
                            ],
                          ),
                        ),
                        const HSpace(7),
                        Flexible(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: AppText.muktaVaani(
                                  LocaleKeys.sub_caste.tr(),
                                  color: context.colorScheme.black,
                                ),
                              ),
                              VSpace.xsmall(),
                              CustomDropdown(
                                items: subCasteList.map((item) => item).toList(),
                                onChanged: (value) {
                                  casteBloc.subCasteId = value;
                                },
                                initialItem: subCasteList.first,
                                excludeSelected: false,
                                decoration: CustomDropdownDecoration(
                                  overlayScrollbarDecoration: const ScrollbarThemeData(
                                    interactive: false,
                                  ),
                                  closedBorder: Border.all(
                                    color: context.colorScheme.textFieldFill,
                                  ),
                                  closedBorderRadius: const BorderRadius.all(
                                    Radius.circular(AppTheme.radius6),
                                  ),
                                  closedFillColor: context.colorScheme.grey100,
                                  expandedBorder: Border.all(
                                    color: context.colorScheme.textFieldFill,
                                  ),
                                  expandedBorderRadius: const BorderRadius.all(
                                    Radius.circular(AppTheme.radius6),
                                  ),
                                  expandedFillColor: context.colorScheme.textFieldFill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    VSpace.small(),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText.muktaVaani(
                        LocaleKeys.mobile_number.tr(),
                        color: AppColors.black,
                      ),
                    ),
                    VSpace.small(),
                    CustomTextField(
                      textInputType: TextInputType.phone,
                      controller: casteBloc.phoneController,
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.enter_your_mobile_number.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.common_msg_required_field.tr();
                        } else if (!(value.length == 10)) {
                          return LocaleKeys.common_msg_invalid_number.tr();
                        }
                        return null;
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[0-9]'),
                        ),
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),

                    VSpace.small(),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText.muktaVaani(
                        LocaleKeys.gender.tr(),
                        color: context.colorScheme.black,
                      ),
                    ),
                    VSpace.xsmall(),
                    CustomDropdown(
                      items: genderList.map((item) => item).toList(),
                      onChanged: (value) {
                        casteBloc.genderId = value;
                      },
                      initialItem: genderList.first,
                      excludeSelected: false,
                      decoration: CustomDropdownDecoration(
                        overlayScrollbarDecoration: const ScrollbarThemeData(
                          interactive: false,
                        ),
                        closedBorder: Border.all(
                          color: context.colorScheme.textFieldFill,
                        ),
                        closedBorderRadius: const BorderRadius.all(
                          Radius.circular(AppTheme.radius6),
                        ),
                        closedFillColor: context.colorScheme.grey100,
                        expandedBorder: Border.all(
                          color: context.colorScheme.textFieldFill,
                        ),
                        expandedBorderRadius: const BorderRadius.all(
                          Radius.circular(AppTheme.radius6),
                        ),
                        expandedFillColor: context.colorScheme.textFieldFill,
                      ),
                    ),

                    VSpace.small(),
                    //////
                    Align(
                      alignment: Alignment.centerLeft,
                      child: AppText.muktaVaani(
                        LocaleKeys.sata_peta.tr(),
                        color: context.colorScheme.black,
                      ),
                    ),
                    VSpace.xsmall(),
                    CustomDropdown(
                      items: sataPeta.map((item) => item).toList(),
                      onChanged: (value) {
                        casteBloc.sataPetaId = value;
                      },
                      initialItem: sataPeta.first,
                      excludeSelected: false,
                      decoration: CustomDropdownDecoration(
                        overlayScrollbarDecoration: const ScrollbarThemeData(
                          interactive: false,
                        ),
                        closedBorder: Border.all(
                          color: context.colorScheme.textFieldFill,
                        ),
                        closedBorderRadius: const BorderRadius.all(
                          Radius.circular(AppTheme.radius6),
                        ),
                        closedFillColor: context.colorScheme.grey100,
                        expandedBorder: Border.all(
                          color: context.colorScheme.textFieldFill,
                        ),
                        expandedBorderRadius: const BorderRadius.all(
                          Radius.circular(AppTheme.radius6),
                        ),
                        expandedFillColor: context.colorScheme.textFieldFill,
                      ),
                    ),
                    VSpace.small(),
                    CustomTextField(
                      controller: casteBloc.educationController,
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.education.tr(),
                        color: context.colorScheme.black,
                      ),
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.education.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.common_msg_required_field.tr();
                        }
                        return null;
                      },
                    ),
                    VSpace.small(),
                    CustomTextField(
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.date_of_birth.tr(),
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.date_of_birth.tr(),
                        color: context.colorScheme.black,
                      ),
                      controller: casteBloc.dateOfBirthController,
                      readOnly: true,
                      focusNode: FocusNode(canRequestFocus: false),
                      suffixIcon: Icon(
                        Icons.calendar_month,
                        color: context.colorScheme.grey400,
                        size: Insets.large,
                      ),
                      validator: (value) => FormValidations.instance.requiredField(
                        errorText: LocaleKeys.dob_required.tr(),
                        value,
                      ),
                      onTap: () async {
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Padding(
                                padding: const EdgeInsets.all(Insets.small),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    CalendarDatePicker(
                                      initialDate: DateTime(1990),
                                      firstDate: DateTime(1800),
                                      lastDate: DateTime(2010),
                                      onDateChanged: (value) {
                                        casteBloc.dateOfBirthController.text =
                                            DateTimeUtils.formatDate(value, 'yyyy-MM-dd') ?? '';
                                      },
                                    ),
                                    VSpace.small(),
                                    AppButton(
                                      isEnabled: true,
                                      contentPadding: const EdgeInsets.all(10),
                                      defaultTextColor: AppColors.white,
                                      text: context.tr(LocaleKeys.save),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    VSpace.small(),
                    CustomTextField(
                      controller: casteBloc.timeOfBirthController,
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.time_of_birth.tr(),
                        color: context.colorScheme.black,
                      ),
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.time_of_birth.tr(),
                      suffixIcon: Icon(
                        Icons.access_time_outlined,
                        color: context.colorScheme.grey400,
                        size: Insets.large,
                      ),
                      validator: (value) => FormValidations.instance.requiredField(
                        errorText: LocaleKeys.tob_required.tr(),
                        value,
                      ),
                      onTap: () {
                        displayTimePicker(context);
                      },
                    ),

                    VSpace.small(),
                    CustomTextField(
                      controller: casteBloc.placeOfBirthController,
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.place_of_birth.tr(),
                        color: context.colorScheme.black,
                      ),
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.place_of_birth.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.common_msg_required_field.tr();
                        }
                        return null;
                      },
                    ),
                    VSpace.small(),
                    CustomTextField(
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.marital_status.tr(),
                        color: context.colorScheme.black,
                      ),
                      fillColor: context.colorScheme.grey100,
                      controller: casteBloc.maritalStatusController,
                      hintText: LocaleKeys.marital_status.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.common_msg_required_field.tr();
                        }
                        return null;
                      },
                    ),
                    VSpace.small(),
                    CustomTextField(
                      textInputType: TextInputType.number,
                      controller: casteBloc.weightController,
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.weight.tr(),
                        color: context.colorScheme.black,
                      ),
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.weight.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.common_msg_required_field.tr();
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        final weight = double.parse(value);
                        if (weight < 10 || weight > 700) {
                          return 'Weight must be at least 10kg';
                        }
                        return null;
                      },
                    ),
                    VSpace.small(),
                    CustomTextField(
                      textInputType: TextInputType.number,
                      controller: casteBloc.heightController,
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.height.tr(),
                        color: context.colorScheme.black,
                      ),
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.height.tr(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.common_msg_required_field.tr();
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        final height = double.parse(value);
                        if (height < 1) {
                          return 'Height must be at least 1 feet';
                        }
                        return null;
                      },
                    ),
                    VSpace.small(),

                    CustomTextField(
                      titleDescription: AppText.muktaVaani(
                        LocaleKeys.occupation.tr(),
                        color: context.colorScheme.black,
                      ),
                      fillColor: context.colorScheme.grey100,
                      hintText: LocaleKeys.occupation.tr(),
                      controller: casteBloc.occupationController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return LocaleKeys.common_msg_required_field.tr();
                        }
                        return null;
                      },
                    ),
                    VSpace.small(),
                    VSpace.small(),
                    Row(
                      children: [
                        BlocConsumer<SalaryBloc, SalaryState>(
                          listener: (context, state) {
                            if (state is FetchSalaryState && state.status == ApiStatus.loaded) {
                              currencyList = state.responseModel?.SalaryDataList?.currencylist;
                              if (currencyList?.isNotEmpty ?? false) {
                                salaryBloc.currencyId = currencyList?.first.id;
                              }
                            }
                            if (state is FetchSalaryState && state.status == ApiStatus.loaded) {
                              // AppUtils.showSnackBar(
                              //   context,
                              //   ,
                              // );
                            }
                            if (state is FetchSalaryState && state.status == ApiStatus.error) {
                              AppUtils.showSnackBar(
                                context,
                                state.errorMsg,
                                isError: true,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (currencyList?.isNotEmpty ?? false) {
                              return Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.muktaVaani(
                                      LocaleKeys.currency.tr(),
                                      color: context.colorScheme.black,
                                    ),
                                    VSpace.xxsmall(),
                                    CustomDropdown<Currencylist>(
                                      items: currencyList ?? [],
                                      initialItem: currencyList?.first,
                                      excludeSelected: false,
                                      onChanged: (value) {
                                        salaryBloc.currencyId = value.id;
                                      },
                                      decoration: CustomDropdownDecoration(
                                        overlayScrollbarDecoration: const ScrollbarThemeData(
                                          interactive: false,
                                        ),
                                        closedBorder: Border.all(
                                          color: context.colorScheme.textFieldFill,
                                        ),
                                        closedBorderRadius: const BorderRadius.all(
                                          Radius.circular(AppTheme.radius6),
                                        ),
                                        closedFillColor: context.colorScheme.grey100,
                                        expandedBorder: Border.all(
                                          color: context.colorScheme.textFieldFill,
                                        ),
                                        expandedBorderRadius: const BorderRadius.all(
                                          Radius.circular(AppTheme.radius6),
                                        ),
                                        expandedFillColor: context.colorScheme.textFieldFill,
                                      ),
                                      headerBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem.currency ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14),
                                        );
                                      },
                                      listItemBuilder: (context, data, isSelected, onItemTap) {
                                        return Text(
                                          data.currency ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is FetchSalaryState &&
                                state.status == ApiStatus.loaded &&
                                (state.responseModel?.SalaryDataList?.salarylist?.isEmpty ?? true)) {
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.formLabel(
                                    context.tr(LocaleKeys.salary),
                                  ),
                                  VSpace.xsmall(),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.textFieldFill,
                                      borderRadius: BorderRadius.circular(AppTheme.radius6),
                                    ),
                                    child: AppText.formLabel(
                                      context.tr(LocaleKeys.no_data),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (state is FetchSalaryState && state.status == ApiStatus.loading) {
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.textFieldFill,
                                  borderRadius: BorderRadius.circular(AppTheme.radius6),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: context.colorScheme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                        HSpace.small(),
                        BlocConsumer<SalaryBloc, SalaryState>(
                          listener: (context, state) {
                            if (state is FetchSalaryState && state.status == ApiStatus.loaded) {
                              salaryList = state.responseModel?.SalaryDataList?.salarylist;
                              if (salaryList?.isNotEmpty ?? false) {
                                salaryBloc.salaryId = salaryList?.first.salary;
                              }
                            }
                            if (state is FetchSalaryState && state.status == ApiStatus.loaded) {
                              // AppUtils.showSnackBar(
                              //   context,
                              //   '',
                              // );
                            }
                            if (state is FetchSalaryState && state.status == ApiStatus.error) {
                              AppUtils.showSnackBar(
                                context,
                                state.errorMsg,
                                isError: true,
                              );
                            }
                          },
                          builder: (context, state) {
                            if (salaryList?.isNotEmpty ?? false) {
                              return Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppText.muktaVaani(
                                      LocaleKeys.salary.tr(),
                                      color: context.colorScheme.black,
                                    ),
                                    VSpace.xxsmall(),
                                    CustomDropdown<Salarylist>(
                                      items: salaryList ?? [],
                                      initialItem: salaryList?.first,
                                      excludeSelected: false,
                                      onChanged: (value) {
                                        salaryBloc.salaryId = value.salary;
                                      },
                                      decoration: CustomDropdownDecoration(
                                        overlayScrollbarDecoration: const ScrollbarThemeData(
                                          interactive: false,
                                        ),
                                        closedBorder: Border.all(
                                          color: context.colorScheme.textFieldFill,
                                        ),
                                        closedBorderRadius: const BorderRadius.all(
                                          Radius.circular(AppTheme.radius6),
                                        ),
                                        closedFillColor: context.colorScheme.grey100,
                                        expandedBorder: Border.all(
                                          color: context.colorScheme.textFieldFill,
                                        ),
                                        expandedBorderRadius: const BorderRadius.all(
                                          Radius.circular(AppTheme.radius6),
                                        ),
                                        expandedFillColor: context.colorScheme.textFieldFill,
                                      ),
                                      headerBuilder: (context, selectedItem) {
                                        return Text(
                                          selectedItem.salary ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14),
                                        );
                                      },
                                      listItemBuilder: (context, data, isSelected, onItemTap) {
                                        return Text(
                                          data.salary ?? '',
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(fontSize: 14),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              );
                            }
                            if (state is FetchSalaryState &&
                                state.status == ApiStatus.loaded &&
                                (state.responseModel?.SalaryDataList?.salarylist?.isEmpty ?? true)) {
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText.formLabel(
                                    context.tr(LocaleKeys.salary),
                                  ),
                                  VSpace.xsmall(),
                                  Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: context.colorScheme.textFieldFill,
                                      borderRadius: BorderRadius.circular(AppTheme.radius6),
                                    ),
                                    child: AppText.formLabel(
                                      context.tr(LocaleKeys.no_data),
                                    ),
                                  ),
                                ],
                              );
                            }
                            if (state is FetchSalaryState && state.status == ApiStatus.loading) {
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 15,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.textFieldFill,
                                  borderRadius: BorderRadius.circular(AppTheme.radius6),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 1,
                                        color: context.colorScheme.primaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                    VSpace.small(),
                    VSpace.small(),
                    CustomInfoBox(
                      color: context.colorScheme.info,
                      widget: Column(
                        children: [
                          bulletPoint(
                            'Upload a passport size photograph or similar. Do not post photos of hobby glasses, hats or selfies.',
                          ),
                          bulletPoint('If this instruction is not followed your resume will be deleted.'),
                          bulletPoint('Girls can register even without uploading a photo.'),
                        ],
                      ),
                    ),
                    VSpace.small(),
                    CustomInfoBox(
                      color: context.colorScheme.danger50,
                      widget: Column(
                        children: [
                          bulletPoint(
                            'Upload a passport size photograph or similar. Do not post photos of hobby glasses, hats or selfies.',
                          ),
                          bulletPoint('If this instruction is not followed your resume will be deleted.'),
                          bulletPoint('Girls can register even without uploading a photo.'),
                        ],
                      ),
                    ),
                    VSpace.small(),
                    AppButton(
                      isEnabled: true,
                      text: LocaleKeys.done.tr(),
                      onPressed: () {
                        if (casteBloc.formKey.currentState!.validate()) {
                          _updateDetail();
                        }
                        ;
                      },
                      textStyle: TextStyle(
                        color: context.colorScheme.white,
                        fontSize: 18,
                      ),
                      borderRadius: 30,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    VSpace.medium(),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  int? getLowerBound(String? salaryRange) {
    if (salaryRange != null) {
      var parts = salaryRange.split('-');
      if (parts.length == 2) {
        return int.tryParse(parts[0]);
      }
    }
    return null;
  }

  Future<void> _updateDetail() async {
    int? income = getLowerBound(salaryBloc.salaryId);
    final updateRequest = BasicDetailResponse(
      name: casteBloc.firstNameController.text,
      firstname: casteBloc.firstNameController.text,
      lastname: casteBloc.lastNameController.text,
      caste: casteBloc.casteId != null ? int.tryParse(casteBloc.casteId!) : null,
      subcaste: casteBloc.subCasteId,
      gender: casteBloc.genderId,
      mobileNumber: casteBloc.phoneController.text,
      sataPeta: casteBloc.sataPetaId,
      educationDetail: casteBloc.educationController.text,
      birthdate: casteBloc.dateOfBirthController.text,
      birthplace: casteBloc.placeOfBirthController.text,
      birthtime: casteBloc.timeOfBirthController.text,
      maritalStatus: casteBloc.maritalStatusController.text,
      weight: double.tryParse(casteBloc.weightController.text) ?? 0.0,
      height: casteBloc.heightController.text,
      occupation: casteBloc.occupationController.text,
      // income: salaryBloc.salaryId != null ? int.parse(salaryBloc.salaryId!) : null,
      income: income,
      userIncomeCurrency: salaryBloc.currencyId,
      profilePhoto: selectedImage?.path,
      userAgent: 'NI-AAPP',
    );
    basicDetailBloc.add(
      SubmitBasicDetailEvent(
        basicDetailResponse: updateRequest,
      ),
    );
  }

  Future<void> _photoUpload() async {
    final photoUploadRequest = PhotoUploadRequest(userAgent: 'NI-AAPP', profilePhotos: '');
    photoUploadBloc.add(
      MakePhotoUploadEvent(
        photoUploadRequest,
        selectedImage,
      ),
    );
  }

  Future displayTimePicker(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: timeOfDay,
    );

    if (time != null) {
      setState(() {
        casteBloc.timeOfBirthController.text = '${time.hour}:${time.minute}';
      });
    }
  }
}

Widget bulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText.muktaVaani(
          '• ',
          fontSize: 12,
          color: AppColors.black,
        ),
        Expanded(
          child: AppText.muktaVaani(
            text,
            fontSize: 12,
            color: AppColors.black,
          ),
        ), // Text
      ],
    ),
  );
}
