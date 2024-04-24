import 'package:flutter/widgets.dart';
import 'package:patidar_melap_app/app/theme/app_colors.dart';
import 'package:patidar_melap_app/app/theme/app_theme.dart';

enum AppTextLevel { paragraph, title, formLabel, style16, bebas }

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.fontWeight,
    this.textDecoration,
    this.overflow,
    this.textAlign = TextAlign.start,
    this.level = AppTextLevel.paragraph,
    this.fontStyle = FontStyle.normal,
  });

  const AppText.paragraph(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines = 2,
    this.textDecoration,
    this.fontWeight,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontStyle = FontStyle.normal,
  }) : level = AppTextLevel.paragraph;

  const AppText.title(
    this.data, {
    super.key,
    this.color,
    this.fontSize,
    this.textDecoration,
    this.maxLines = 2,
    this.fontWeight = FontWeight.w700,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontStyle = FontStyle.normal,
  }) : level = AppTextLevel.title;

  const AppText.formLabel(
    this.data, {
    super.key,
    this.color = AppColors.grey500,
    this.fontSize = 14,
    this.textDecoration,
    this.maxLines = 2,
    this.fontWeight = FontWeight.w600,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontStyle = FontStyle.normal,
  }) : level = AppTextLevel.formLabel;

  const AppText.style16(
    this.data, {
    super.key,
    this.color = AppColors.white,
    this.fontSize = 16,
    this.textDecoration,
    this.maxLines = 2,
    this.fontWeight = FontWeight.w500,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontStyle = FontStyle.normal,
  }) : level = AppTextLevel.style16;

  const AppText.bebas(
    this.data, {
    super.key,
    this.color = AppColors.white,
    this.fontSize = 16,
    this.textDecoration,
    this.maxLines = 2,
    this.fontWeight = FontWeight.w500,
    this.overflow = TextOverflow.ellipsis,
    this.textAlign = TextAlign.start,
    this.fontStyle = FontStyle.normal,
  }) : level = AppTextLevel.bebas;

  final String data;
  final AppTextLevel level;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final TextOverflow? overflow;
  final FontStyle fontStyle;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.maybeOf(context);
    final color = this.color ?? theme?.colors.textColor;
    final style = () {
      switch (level) {
        case AppTextLevel.paragraph:
          return theme?.typography.paragraph;
        case AppTextLevel.title:
          return theme?.typography.title;
        case AppTextLevel.formLabel:
          return theme?.typography.formLabel;
        case AppTextLevel.style16:
          return theme?.typography.style16;
        case AppTextLevel.bebas:
          return theme?.typography.bebas;
      }
    }();
    return Text(
      data,
      style: style?.copyWith(
        color: color,
        fontSize: fontSize,
        height: 1.2,
        fontWeight: fontWeight,
        decoration: textDecoration,
        decorationColor: theme?.colors.textColor,
        overflow: overflow,
        fontFamily: level == AppTextLevel.bebas ? AppTheme.fontFamily : AppTheme.muktaVaani,
        fontStyle: fontStyle,
      ),
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
