import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patidar_melap_app/app/config/api_config.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/helpers/injection.dart';
import 'package:patidar_melap_app/app/routes/app_router.dart';
import 'package:patidar_melap_app/core/data/services/auth.service.dart';
import 'package:patidar_melap_app/core/presentation/utils/app_utils.dart';
import 'package:patidar_melap_app/core/presentation/widgets/app_dialog.dart';
import 'package:patidar_melap_app/gen/locale_keys.g.dart';
import 'package:patidar_melap_app/modules/auth/log_out/logout_bloc.dart';
import 'package:patidar_melap_app/modules/auth/log_out/logout_state.dart';
import 'package:patidar_melap_app/modules/auth/repository/auth_repository.dart';
import 'package:patidar_melap_app/modules/profile/bloc/profile_bloc.dart';
import 'package:patidar_melap_app/modules/profile/repository/profile_repository.dart';
import 'package:patidar_melap_app/modules/profile/widget/custom_profile_tabs.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget implements AutoRouteWrapper {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

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
        RepositoryProvider(
          create: (context) => ProfileRepository(),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(
            authenticationRepository: RepositoryProvider.of<AuthRepository>(context),
          ),
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
    );
  }
}

class _ProfileScreenState extends State<ProfileScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    getIt<IAuthService>().getAccessToken().fold(() => null, ApiClient.setAuthorizationToken);
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late LogoutBloc logoutBloc;
  late ProfileBloc profileBloc;

  @override
  void didChangeDependencies() {
    logoutBloc = context.read<LogoutBloc>();
    profileBloc = context.read<ProfileBloc>();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileBloc, FetchProfileState>(
        listener: (context, state) {
          if (state.status == ApiStatus.loaded) {
            // AppUtils.showSnackBar(
            //   context,
            //   LocaleKeys.logout_success.tr(),
            // );
          } else if (state.status == ApiStatus.error) {
            AppUtils.showSnackBar(
              context,
              state.responseModel?.message,
              isError: true,
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 20, right: 5),
                    height: MediaQuery.of(context).size.height * 0.27,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red, Colors.pink.shade600],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BlocConsumer<LogoutBloc, LogoutState>(
                          listener: (context, state) {
                            if (state.status == ApiStatus.loaded) {
                              AppUtils.showSnackBar(
                                context,
                                LocaleKeys.logout_success.tr(),
                              );
                              logout(context);
                              context.maybePop();
                            } else if (state.status == ApiStatus.error) {
                              AppUtils.showSnackBar(
                                context,
                                state.message,
                                isError: true,
                              );
                            }
                          },
                          builder: (context, state) {
                            return IconButton(
                              onPressed: () {
                                showDialog<void>(
                                  context: context,
                                  useRootNavigator: false,
                                  builder: (_) => CustomAlertDialog(
                                    showAction: false,
                                    positiveText: LocaleKeys.yes.tr(),
                                    negativeText: LocaleKeys.no.tr(),
                                    title: LocaleKeys.logout.tr(),
                                    content: LocaleKeys.hint_text_confirm_logout.tr(),
                                    onAction: (action) async {
                                      if (action == DialogAction.positive) {
                                        context.read<LogoutBloc>().logoutEvent();
                                      }
                                      if (action == DialogAction.negative) {
                                        await context.maybePop();
                                      }
                                    },
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.logout,
                                size: 30,
                                color: context.colorScheme.white,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      CustomProfileTabs(
                        disableColor: true,
                        onTap: () {},
                        text: LocaleKeys.add_more_photos.tr(),
                      ),
                      AbsorbPointer(
                        absorbing: false,
                        child: CustomProfileTabs(
                          disableColor: false,
                          onTap: () {
                            context.pushRoute(const BasicDetailsRoute());
                          },
                          text: LocaleKeys.basic_details.tr(),
                        ),
                      ),
                      CustomProfileTabs(
                        disableColor: false,
                        onTap: () {
                          context.pushRoute(const FamilyInfoRoute());
                        },
                        text: LocaleKeys.family_information.tr(),
                      ),
                      CustomProfileTabs(
                        disableColor: false,
                        onTap: () {},
                        text: LocaleKeys.other_details.tr(),
                      ),
                    ],
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
              Positioned(
                top: 130,
                right: 110,
                child: CircleAvatar(
                  minRadius: 95,
                  maxRadius: 95,
                  backgroundColor: context.colorScheme.grey200,
                  // backgroundImage: profileBloc.selectedImage != null ? NetworkImage(profileBloc.selectedImage ?? '') : null,
                  child: state.status == ApiStatus.loading
                      ? const CircularProgressIndicator()
                      : Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  profileBloc.selectedImage ?? '',
                                )),
                            borderRadius: BorderRadius.circular(130),
                          ),
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    // await context.maybePop();
    await context.router.replaceAll(
      [const LoginRoute()],
    );
  }
}
