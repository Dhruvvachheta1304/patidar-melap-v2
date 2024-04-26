import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:rxdart/rxdart.dart';

class AppUtils {
  static BehaviorSubject<bool> permissionStream = BehaviorSubject<bool>.seeded(false);
  static BehaviorSubject<bool> isMockLocationStream = BehaviorSubject<bool>.seeded(false);

  static void showSnackBar(BuildContext? context, String? text, {bool? isError = false}) {
    if (context != null) {
      final snackBar = SnackBar(
        dismissDirection: DismissDirection.startToEnd,
        backgroundColor: (isError ?? false) ? context.colorScheme.error : context.colorScheme.primaryColor,
        content: AppText.paragraph(
          text ?? 'Something went wrong, please try again.',
          fontWeight: FontWeight.w500,
          fontSize: 16,
          maxLines: 3,
        ),
        behavior: SnackBarBehavior.fixed,
        // margin: const EdgeInsets.only(
        //   //bottom: MediaQuery.of(context).size.height - 90,
        //   top: 10,
        // ),
        duration: const Duration(seconds: 2),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  static String getDeviceType() {
    if (Platform.isAndroid) {
      return 'ANDROID';
    } else if (Platform.isIOS) {
      return 'IOS';
    } else {
      return '';
    }
  }

  static Future<String?> getDeviceId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
    return null;
  }

  static Future<String> getDeviceVersion() async {
    var osVersion = '';
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      osVersion = androidInfo.version.release;
    } else {
      final iosInfo = await DeviceInfoPlugin().iosInfo;
      osVersion = iosInfo.systemVersion;
    }
    return osVersion;
  }

  static String? emptyFieldValidation(String? string) {
    if (string?.isNotEmpty ?? false) {
      return null;
    }
    return 'This field cannot be empty';
  }
}
