import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/app_colors.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:patidar_melap_app/core/data/services/auth.service.dart';
import 'package:patidar_melap_app/core/presentation/widgets/app_button.dart';
import 'package:patidar_melap_app/core/presentation/widgets/custom_text_field.dart';
import 'package:patidar_melap_app/gen/assets.gen.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/model/send_otp_request.dart';

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
        // BlocProvider(
        //   create: (context) => CountryCodeBloc(
        //     repository: RepositoryProvider.of<AuthRepository>(context),
        //   )..add(FetchCountryCodeEvent()),
        // ),
        BlocProvider(
          create: (context) => SignUpBloc(
            repository: RepositoryProvider.of<AuthRepository>(context),
          )..add(SendOtpEvent(sendOtpRequest: SendOtpRequest())),
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
                child: Column(
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
                          return 'This field is required';
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

                      // controller: profileBloc.confirmPassword,
                      // suffixIcon: IconButton(
                      //   icon: profileBloc.obscureTextConfirmPwd
                      //       ? Icon(
                      //     Icons.visibility_off_outlined,
                      //     size: 26,
                      //     color: context.colorScheme.grey400,
                      //   )
                      //       : Icon(
                      //     Icons.visibility_outlined,
                      //     size: 26,
                      //     color: context.colorScheme.grey400,
                      //   ),
                      //   onPressed: () {
                      //     setState(() {
                      //       profileBloc.obscureTextConfirmPwd = profileBloc.obscureTextConfirmPwd ? false : true;
                      //     });
                      //   },
                      // ),
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
                          return 'This field is required';
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
                          return 'This field is required';
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
                          // textStyle: const TextStyle(fontSize: 18),
                          dialogSize: const Size.fromHeight(420),
                          backgroundColor: Colors.red,
                          initialSelection: 'IN',
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
                                return 'This field is required';
                              } else if (!(value.length == 10)) {
                                return 'number is invalid';
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
                      onPressed: () {
                        if (signUpBloc.formKey.currentState!.validate()) {}
                      },
                      textStyle: TextStyle(
                        color: context.colorScheme.white,
                        fontSize: 18,
                      ),
                      borderRadius: 30,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _onCountryChange(CountryCode countryCode) {
  log('New Country selected: ${countryCode.dialCode}');
}
