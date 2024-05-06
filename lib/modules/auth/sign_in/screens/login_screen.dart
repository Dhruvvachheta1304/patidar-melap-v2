import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/routes/app_router.dart';
import 'package:patidar_melap_app/app/theme/app_colors.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:patidar_melap_app/core/data/services/auth.service.dart';
import 'package:patidar_melap_app/core/presentation/utils/app_utils.dart';
import 'package:patidar_melap_app/core/presentation/widgets/app_button.dart';
import 'package:patidar_melap_app/core/presentation/widgets/custom_text_field.dart';
import 'package:patidar_melap_app/gen/assets.gen.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';
import 'package:patidar_melap_app/modules/auth/sign_in/bloc/login_bloc.dart';
import 'package:patidar_melap_app/modules/auth/sign_in/model/login_request.dart';

@RoutePage()
class LoginPage extends StatefulWidget implements AutoRouteWrapper {
  const LoginPage({super.key});

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
      ],
      // child: this,
      child: BlocProvider(
        create: (context) => LoginBloc(
          repository: RepositoryProvider.of<AuthRepository>(context),
        ),
        child: this,
      ),
    );
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late LoginBloc loginBloc;

  @override
  void didChangeDependencies() {
    loginBloc = context.read<LoginBloc>();
    super.didChangeDependencies();
  }

  Future<void> _signIn() async {
    TextInput.finishAutofillContext();
    FocusScope.of(context).requestFocus(FocusNode());
    final form = loginBloc.formKey.currentState;
    if (form != null && form.validate()) {
      final request = LogInRequest(
        mobileNumber: loginBloc.phoneController.text,
        password: loginBloc.passwordController.text,
        userAgent: 'NI-AAPP',
      );
      loginBloc.add(MakeLoginEvent(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == ApiStatus.error) {
          AppUtils.showSnackBar(
            context,
            state.responseModel?.message,
            isError: true,
          );
        }
        if (state.status == ApiStatus.loaded) {
          AppUtils.showSnackBar(
            context,
            LocaleKeys.login_done.tr(),
          );
          context.replaceRoute(
            const ProfileRoute(),
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: loginBloc.formKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.zero,
                    child: Assets.images.loginScreen.image(),
                  ),
                  VSpace.medium(),
                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: AppText.muktaVaani(
                            LocaleKeys.mobile_number.tr(),
                            color: AppColors.grey700,
                          ),
                        ),
                        VSpace.small(),
                        CustomTextField(
                          textInputType: TextInputType.phone,
                          controller: loginBloc.phoneController,
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
                        VSpace.large(),
                        CustomTextField(
                          controller: loginBloc.passwordController,

                          fillColor: context.colorScheme.grey100,
                          // validator: _confirmPasswordValidator,
                          obscuringCharacter: '*',
                          hintText: LocaleKeys.enter_your_password.tr(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                loginBloc.passwordVisible = !loginBloc.passwordVisible;
                              });
                            },
                            icon: Icon(
                              loginBloc.passwordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                              size: 27,
                            ),
                          ),
                          obscureText: loginBloc.passwordVisible ? false : true,
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
                        VSpace.xxxlarge(),
                        AppButton(
                          text: LocaleKeys.login.tr(),
                          isEnabled: state.status == ApiStatus.loading ? false : true,
                          onPressed: _signIn,
                          textStyle: TextStyle(
                            color: context.colorScheme.white,
                            fontSize: 18,
                          ),
                          borderRadius: 30,
                          contentPadding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        VSpace.xxxlarge(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText.muktaVaani(
                              LocaleKeys.hint_text_account.tr(),
                              fontSize: 13,
                              color: context.colorScheme.grey400,
                            ),
                            const HSpace(5),
                            InkWell(
                              onTap: () {
                                context.pushRoute(
                                  const SignUpRoute(),
                                );
                              },
                              child: AppText.muktaVaani(
                                LocaleKeys.register_here.tr(),
                                fontSize: 13,
                                color: context.colorScheme.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
