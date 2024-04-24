import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:patidar_melap_app/app/theme/data.dart';

class AppTheme extends InheritedWidget {
  const AppTheme({
    required this.data,
    required super.child,
    super.key,
  });

  final AppThemeData data;

  static AppThemeData? maybeOf(BuildContext context) {
    final widget = context.dependOnInheritedWidgetOfExactType<AppTheme>();
    return widget?.data;
  }

  @override
  bool updateShouldNotify(covariant AppTheme oldWidget) {
    return data != oldWidget.data;
  }

  static const String fontFamily = 'muktaVaani';
  static const String muktaVaani = 'bebasNeue';
  static const double defaultRadius = 16;
  static const double radius6 = 6;
  static const double radius10 = 10;
  static const double radius12 = 12;
  static const double radius20 = 20;
  static const double radius24 = 24;

  static final BorderRadius defaultBoardRadius = BorderRadius.circular(defaultRadius);
  static final BorderRadius borderRadius6 = BorderRadius.circular(radius6);
  static final BorderRadius borderRadius10 = BorderRadius.circular(radius10);
  static final BorderRadius borderRadius12 = BorderRadius.circular(radius12);
  static final BorderRadius borderRadius20 = BorderRadius.circular(radius20);
}
