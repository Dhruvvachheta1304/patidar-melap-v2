import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:patidar_melap_app/app/routes/route_guards/auth_guard.dart';
import 'package:patidar_melap_app/core/presentation/widgets/image_cropper/custom_image_cropper.dart';
import 'package:patidar_melap_app/modules/auth/sign_in/screens/login_screen.dart';
import 'package:patidar_melap_app/modules/auth/sign_up/screens/sign_up_screen.dart';
import 'package:patidar_melap_app/modules/basic_detail/screens/basic_details_screen.dart';
import 'package:patidar_melap_app/modules/bottom_navigation_bar.dart';
import 'package:patidar_melap_app/modules/family_information/screens/family_information_screen.dart';
import 'package:patidar_melap_app/modules/profile/screen/profile_screen.dart';
import 'package:patidar_melap_app/modules/splash/splash_screen.dart';

part 'app_router.gr.dart';

/// [Doc Link](abc)
@AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: FamilyInfoRoute.page,
          // initial: truerue,
        ),
        AutoRoute(
          // initial: true,
          page: SplashRoute.page,
          path: '/',
          guards: [
            AuthGuard(),
          ],
        ),
        AutoRoute(
          page: LoginRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: ProfileRoute.page,
          // initial: true,path: '/',
          path: '/',
        ),
        AutoRoute(
          page: SignUpRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: SignUpRoute.page,
          // initial: true,
        ),
        AutoRoute(
          page: BasicDetailsRoute.page,
          // initial: true,
        ),
        AutoRoute(page: CustomImageCropperRoute.page),
        AutoRoute(
          page: BottomNavigationBarRoute.page,
          children: [
            AutoRoute(page: SignUpRoute.page),
          ],
        ),
      ];
}
