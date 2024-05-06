import 'package:flutter/widgets.dart';
import 'package:patidar_melap_app/app/theme/app_colors.dart';

class AppColorsData {
  const AppColorsData(
      {required this.grey400,
      required this.background,
      required this.foreground,
      required this.error,
      required this.cursorColor,
      required this.textColor,
      required this.outlineBorderColor,
      required this.underlineBorderColor,
      required this.comboWidgetBackgroundColor,
      required this.gray900,
      required this.primaryColor,
      required this.secondaryS300,
      required this.secondaryS500,
      required this.mainM900,
      required this.secondaryS900,
      required this.grey100,
      required this.grey700,
      required this.gray600,
      required this.secondaryS400,
      required this.mainM200,
      required this.mainM300,
      required this.grayG900,
      required this.secondaryS800,
      required this.gray800,
      required this.grey500,
      required this.mainM800,
      required this.lavenderColor,
      required this.textFieldFill,
      required this.white,
      required this.black,
      required this.danger500,
      required this.transparent,
      required this.scaffoldBgColor,
      required this.primary100,
      required this.grey300,
      required this.success500,
      required this.grey200,
      required this.primary600,
      required this.info,
      required this.danger50});

  factory AppColorsData.light() => const AppColorsData(
        danger50: AppColors.danger50,
        info: AppColors.info,
        foreground: Color(0xffffffff),
        background: AppColors.backgroundColorDark,
        error: Color(0xffff0000),
        cursorColor: AppColors.cursorColorDark,
        textColor: AppColors.white,
        outlineBorderColor: AppColors.outlineBorderColorDark,
        underlineBorderColor: AppColors.underlineBorderColorDark,
        comboWidgetBackgroundColor: AppColors.comboWidgetBackgroundColor,
        primaryColor: AppColors.primaryColor,
        secondaryS300: AppColors.secondaryS300,
        secondaryS500: AppColors.secondaryS500,
        gray900: AppColors.gray900,
        mainM900: AppColors.mainM900,
        secondaryS900: AppColors.secondaryS900,
        grey100: AppColors.grey100,
        grey700: AppColors.grey700,
        gray600: AppColors.gray600,
        secondaryS400: AppColors.secondaryS400,
        mainM200: AppColors.mainM200,
        mainM300: AppColors.mainM300,
        grayG900: AppColors.grayG900,
        secondaryS800: AppColors.secondaryS800,
        gray800: AppColors.gray800,
        grey500: AppColors.grey500,
        mainM800: AppColors.mainM800,
        lavenderColor: AppColors.lavenderColor,
        textFieldFill: AppColors.textFieldFill,
        grey400: AppColors.grey400,
        white: AppColors.white,
        black: AppColors.black,
        danger500: AppColors.danger500,
        transparent: AppColors.transparent,
        scaffoldBgColor: AppColors.scaffoldBgColor,
        primary100: AppColors.primary100,
        grey300: AppColors.grey300,
        success500: AppColors.success500,
        grey200: AppColors.grey200,
        primary600: AppColors.primary600,
      );

  factory AppColorsData.dark() => const AppColorsData(
        danger50: AppColors.danger50,
        info: AppColors.info,
        danger500: AppColors.danger500,
        grey400: AppColors.grey400,
        foreground: Color(0xffffffff),
        background: AppColors.backgroundColorDark,
        error: Color(0xffff0000),
        cursorColor: AppColors.cursorColorDark,
        textColor: AppColors.white,
        outlineBorderColor: AppColors.outlineBorderColorDark,
        underlineBorderColor: AppColors.underlineBorderColorDark,
        comboWidgetBackgroundColor: AppColors.comboWidgetBackgroundColor,
        primaryColor: AppColors.primaryColor,
        secondaryS300: AppColors.secondaryS300,
        secondaryS500: AppColors.secondaryS500,
        gray900: AppColors.gray900,
        mainM900: AppColors.mainM900,
        secondaryS900: AppColors.secondaryS900,
        grey100: AppColors.grey100,
        grey700: AppColors.grey700,
        gray600: AppColors.gray600,
        grey500: AppColors.grey500,
        secondaryS400: AppColors.secondaryS400,
        mainM200: AppColors.mainM200,
        mainM300: AppColors.mainM300,
        grayG900: AppColors.grayG900,
        secondaryS800: AppColors.secondaryS800,
        gray800: AppColors.gray800,
        mainM800: AppColors.mainM800,
        lavenderColor: AppColors.lavenderColor,
        textFieldFill: AppColors.textFieldFill,
        white: AppColors.white,
        transparent: AppColors.transparent,
        black: AppColors.black,
        scaffoldBgColor: AppColors.scaffoldBgColor,
        primary100: AppColors.primary100,
        grey300: AppColors.grey300,
        success500: AppColors.success500,
        grey200: AppColors.grey200,
        primary600: AppColors.primary600,
      );

  final Color background;
  final Color foreground;
  final Color error;
  final Color cursorColor;
  final Color textColor;
  final Color outlineBorderColor;
  final Color underlineBorderColor;
  final Color comboWidgetBackgroundColor;
  final Color primaryColor;
  final Color secondaryS500;
  final Color secondaryS300;
  final Color secondaryS900;
  final Color secondaryS400;
  final Color secondaryS800;
  final Color gray900;
  final Color grey100;
  final Color grey300;
  final Color grey700;
  final Color gray600;
  final Color gray800;
  final Color mainM200;
  final Color mainM300;
  final Color mainM900;
  final Color mainM800;
  final Color grayG900;
  final Color grey500;
  final Color grey400;
  final Color lavenderColor;
  final Color textFieldFill;
  final Color white;
  final Color black;
  final Color danger500;
  final Color transparent;
  final Color scaffoldBgColor;
  final Color primary100;
  final Color success500;
  final Color grey200;
  final Color primary600;
  final Color info;
  final Color danger50;
}
