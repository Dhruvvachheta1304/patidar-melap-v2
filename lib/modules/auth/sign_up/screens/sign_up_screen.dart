import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/routes/app_router.dart';
import 'package:patidar_melap_app/app/theme/app_colors.dart';
import 'package:patidar_melap_app/app/theme/app_text_style.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:patidar_melap_app/core/data/services/auth.service.dart';
import 'package:patidar_melap_app/core/presentation/utils/app_utils.dart';
import 'package:patidar_melap_app/core/presentation/widgets/app_button.dart';
import 'package:patidar_melap_app/core/presentation/widgets/custom_text_field.dart';
import 'package:patidar_melap_app/gen/assets.gen.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/send_otp_request.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/sign_up_request.dart';
import 'package:pinput/pinput.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget implements AutoRouteWrapper {
  const SignUpScreen({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => const AuthService(),
        ),
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        BlocProvider(
          create: (context) => SignUpBloc(
            repository: RepositoryProvider.of<AuthRepository>(context),
          ),
        ),
      ],
      child: this,
    );
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpBloc signUpBloc;

  CountryCode? countryCode = CountryCode(dialCode: '+91');

  late bool? isEnabled;

  @override
  void didChangeDependencies() {
    signUpBloc = context.read<SignUpBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: signUpBloc.formKey,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.zero,
                child: Assets.images.signUpScreen.image(),
              ),
              VSpace.medium(),
              Padding(
                padding: const EdgeInsets.all(18),
                child: BlocConsumer<SignUpBloc, SignUpState>(
                  listener: (context, state) {
                    if (state is SendOtpState && state.responseModel?.status == 'success') {
                      AppUtils.showSnackBar(
                        context,
                        LocaleKeys.otp_msg_success.tr(),
                        // isError: true,
                      );
                      _showOtpBottomSheet(context);
                    }

                    if (state is SendOtpState && state.responseModel?.status == 'error') {
                      log('Error message: ${state.responseModel?.message}');
                      AppUtils.showSnackBar(
                        context,
                        state.responseModel?.message,
                        isError: true,
                      );
                    }

                    if (state is RegisterState && state.status == ApiStatus.loading) {
                      isEnabled = false;
                    }

                    if (state is RegisterState && state.responseModel?.status == 'success') {
                      AppUtils.showSnackBar(
                        context,
                        LocaleKeys.sign_up_done.tr(),
                      );
                      context.router.pushAndPopUntil(
                        const ProfileRoute(),
                        predicate: (_) => false,
                      );
                    }

                    if (state is RegisterState && state.responseModel?.status == 'error') {
                      // FocusScope.of(context).requestFocus(FocusNode());
                      // Navigator.pop(context);
                      AppUtils.showSnackBar(
                        isTop: true,
                        context,
                        state.responseModel?.message,
                        isError: true,
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          controller: signUpBloc.userNameController,
                          titleDescription: AppText.muktaVaani(
                            LocaleKeys.username.tr(),
                            color: AppColors.grey700,
                          ),
                          fillColor: context.colorScheme.grey100,
                          hintText: LocaleKeys.enter_your_username.tr(),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.common_msg_required_field.tr();
                            } else if (!(value.length >= 8 && value.length <= 20)) {
                              return 'username must be 9 to 20 character, no space include';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z]'),
                            ),
                            LengthLimitingTextInputFormatter(20),
                          ],
                        ),
                        VSpace.large(),
                        CustomTextField(
                          controller: signUpBloc.passWordController,

                          fillColor: context.colorScheme.grey100,
                          // validator: _confirmPasswordValidator,
                          obscuringCharacter: '*',
                          hintText: LocaleKeys.enter_your_password.tr(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                signUpBloc.passwordVisible = !signUpBloc.passwordVisible;
                              });
                            },
                            icon: Icon(
                              signUpBloc.passwordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 27,
                            ),
                          ),
                          obscureText: signUpBloc.passwordVisible ? false : true,
                          textInputType: TextInputType.visiblePassword,
                          titleDescription: AppText.muktaVaani(
                            LocaleKeys.password.tr(),
                            color: AppColors.grey700,
                          ),
                          validator: (value) {
                            RegExp regex = RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{8,}$',
                            );
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.common_msg_required_field.tr();
                            } else if (!(value.length >= 8 && regex.hasMatch(value))) {
                              return 'Minimum eight characters, at least one uppercase letter, one lowecase letter, one number and one special character';
                            }
                            return null;
                          },
                        ),
                        VSpace.large(),
                        CustomTextField(
                          controller: signUpBloc.emailController,
                          textInputType: TextInputType.emailAddress,
                          titleDescription: AppText.muktaVaani(
                            LocaleKeys.email.tr(),
                            color: AppColors.grey700,
                          ),
                          fillColor: context.colorScheme.grey100,
                          hintText: LocaleKeys.enter_your_email.tr(),
                          validator: (value) {
                            RegExp regex = RegExp(
                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                            );
                            if (value == null || value.isEmpty) {
                              return LocaleKeys.common_msg_required_field.tr();
                            } else if (!regex.hasMatch(value)) {
                              return 'Email is invalid';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9@.]'),
                            ),
                          ],
                        ),
                        VSpace.large(),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText.muktaVaani(
                            LocaleKeys.mobile_number.tr(),
                            color: AppColors.grey700,
                          ),
                        ),
                        VSpace.small(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CountryCodePicker(
                              flagWidth: 22,
                              dialogSize: const Size.fromHeight(420),
                              backgroundColor: Colors.red,
                              initialSelection: countryCode?.dialCode,
                              onChanged: _onCountryChange,
                              onInit: (code) => debugPrint(
                                'on init ${code?.name} ${code?.dialCode} ${code?.name}',
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: CustomTextField(
                                textInputType: TextInputType.phone,
                                controller: signUpBloc.phoneController,
                                fillColor: context.colorScheme.grey100,
                                hintText: LocaleKeys.enter_your_mobile_number.tr(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return LocaleKeys.common_msg_required_field.tr();
                                  } else if (!(value.length == 10)) {
                                    return LocaleKeys.common_msg_invalid_number.tr();
                                    ;
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
                            ),
                          ],
                        ),
                        VSpace.xxxlarge(),
                        AppButton(
                          text: LocaleKeys.register.tr(),
                          isEnabled: state is SendOtpState && state.status == ApiStatus.loading ? false : true,
                          onPressed: () {
                            // onRegisterPressed(context);
                            // _sendOtp();

                            FocusScope.of(context).requestFocus(FocusNode());
                            if (signUpBloc.formKey.currentState!.validate()) {
                              _sendOtp();
                            }

                            /////

                            // _showOtpBottomSheet(context);
                          },
                          textStyle: context.textTheme?.muktaVaani.copyWith(
                            color: context.colorScheme.white,
                            fontSize: 18,
                          ),
                          borderRadius: 30,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _sendOtp() async {
    final sendOtpRequest = SendOtpRequest(
      countryCode: countryCode?.dialCode,
      mobileNumber: signUpBloc.phoneController.text,
      type: 'register',
    );
    signUpBloc.add(
      SendOtpEvent(
        sendOtpRequest: sendOtpRequest,
      ),
    );
  }

  Future<void> _signUp() async {
    final signUpRequest = SignUpRequest(
      username: signUpBloc.userNameController.text,
      email: signUpBloc.emailController.text,
      password: signUpBloc.passWordController.text,
      otp: signUpBloc.otpController.text,
      mobileNumber: signUpBloc.phoneController.text,
      countryCode: countryCode?.dialCode,
      userAgent: 'NI-AAPP',
    );
    signUpBloc.add(
      RegisterEvent(signUpRequest: signUpRequest),
    );
  }

  void _onCountryChange(CountryCode countryCode) {
    this.countryCode = countryCode;
    log('New Country selected: ${countryCode.dialCode}');
  }

  // Call this method when the register button is pressed and all fields are valid
  void onRegisterPressed(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
    if (signUpBloc.formKey.currentState!.validate()) {
      _showOtpBottomSheet(context);
      _sendOtp();
    }
  }

  void _showOtpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colorScheme.white,
      showDragHandle: true,
      barrierColor: context.colorScheme.transparent,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (BuildContext context) {
        return SingleChildScrollView(
          // Wrap content with SingleChildScrollView
          child: Container(
            // height: 350,
            width: double.maxFinite,
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText.muktaVaani(
                      LocaleKeys.enter_four_digit_code.tr(),
                      fontSize: 24,
                      color: context.colorScheme.black,
                    ),
                    VSpace.xsmall(),
                    AppText.muktaVaani(
                      LocaleKeys.otp_hint_text.tr(),
                      color: context.colorScheme.grey400,
                    ),
                    VSpace.xlarge(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: signUpBloc.otpFormKey,
                          child: Pinput(
                            separatorBuilder: (index) => HSpace.xlarge(),
                            androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
                            focusedPinTheme: focusPinTheme,
                            defaultPinTheme: defaultPinTheme,
                            submittedPinTheme: defaultPinTheme,
                            pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                            controller: signUpBloc.otpController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return LocaleKeys.please_enter_the_otp.tr();
                              }
                              if (!RegExp(r'^[0-9]+$').hasMatch(value) || value.length != 4) {
                                return LocaleKeys.invalid_otp.tr();
                              }

                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const VSpace(180),
                AppButton(
                  text: LocaleKeys.continue_title.tr(),
                  // isEnabled: state is SendOtpState && state.status == ApiStatus.loading ? false : true,
                  // isEnabled: isEnabled == false ? false : true,
                  isEnabled: true,
                  // isEnabled: !(context.watch<SignUpBloc>().state is SendOtpState && context.watch<SignUpBloc>().state),
                  onPressed: () {
                    if (signUpBloc.otpFormKey.currentState!.validate()) {
                      _signUp();
                    }
                    log(signUpBloc.otpController.text);
                    debugPrint(signUpBloc.otpController.text);
                  },
                  textStyle: context.textTheme?.muktaVaani.copyWith(
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
        );
      },
    ).then(
      (value) => {
        signUpBloc.otpController.clear(),
      },
    );
  }

  final defaultPinTheme = PinTheme(
    width: Insets.xxxlarge,
    height: Insets.xxxlarge,
    textStyle: const TextStyle(
      fontSize: Insets.xlarge,
      color: Color.fromRGBO(30, 60, 87, 1),
      fontWeight: AppFontWeight.medium,
    ),
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.grey700),
      borderRadius: BorderRadius.circular(10),
    ),
  );

  final focusPinTheme = PinTheme(
    width: Insets.xxxlarge,
    height: Insets.xxxlarge,
    textStyle: const TextStyle(
      fontSize: Insets.large,
      color: Colors.black,
      fontWeight: AppFontWeight.medium,
    ),
    decoration: BoxDecoration(
      border: Border.all(),
      borderRadius: BorderRadius.circular(8),
    ),
  );
}
