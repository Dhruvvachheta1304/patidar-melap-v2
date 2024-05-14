import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:patidar_melap_app/app/config/api_config.dart';
import 'package:patidar_melap_app/app/config/app_config.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/app/helpers/injection.dart';
import 'package:patidar_melap_app/app/observers/app_bloc_observer.dart';
import 'package:patidar_melap_app/core/data/services/auth.service.dart';
// import 'package:leak_tracker/leak_tracker.dart';

/// This function is one of the core function that should be run before we even
/// reach to the [MaterialApp] This function initializes the following:
///
/// * [HydratedBloc] for caching the state
/// * [AppBlocObserver] for printing the events and state logs
/// * [AuthService] for getting and setting the Userdata
Future<void> bootstrap(FutureOr<Widget> Function() builder, Env env) async {
  WidgetsFlutterBinding.ensureInitialized();

  ///  Initializing localizations
  await EasyLocalization.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  // enableLeakTracking();
  initializeSingletons();
  AppConfig.setEnvConfig(env);
  await getIt<IAuthService>().init();

  ///setting up the Dio configurations
  await ApiClient.init(isApiCacheEnabled: false);
  Bloc.observer = getIt<AppBlocObserver>();

  // MemoryAllocations.instance.addListener((ObjectEvent event) {
  //   dispatchObjectEvent(event.toMap());
  // });
  getIt<IAuthService>().getAccessToken().fold(() => null, ApiClient.setAuthorizationToken);

  runApp(await builder());
}

void initializeSingletons() {
  getIt
    ..registerSingleton<Logger>(
      Logger(
        filter: ProductionFilter(),
        printer: PrettyPrinter(),
        output: ConsoleOutput(),
      ),
    )
    ..registerSingleton(AppBlocObserver())
    ..registerSingleton<IAuthService>(const AuthService());
}
