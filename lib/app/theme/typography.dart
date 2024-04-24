import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:patidar_melap_app/app/theme/app_theme.dart';

class AppTypographyData extends Equatable {
  const AppTypographyData({
    required this.paragraph,
    required this.title,
    required this.formLabel,
    required this.style16,
    required this.bebas,
  });

  factory AppTypographyData.regular() => const AppTypographyData(
        title: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          fontFamily: AppTheme.fontFamily,
          fontStyle: FontStyle.normal,
        ),
        paragraph: TextStyle(
          fontSize: 20,
          fontFamily: AppTheme.fontFamily,
        ),
        formLabel: TextStyle(
          fontSize: 14,
          fontFamily: AppTheme.fontFamily,
        ),
        style16: TextStyle(
          fontSize: 16,
          fontFamily: AppTheme.fontFamily,
        ),
        bebas: TextStyle(
          fontSize: 16,
          fontFamily: AppTheme.muktaVaani,
        ),
      );

  final TextStyle title;
  final TextStyle paragraph;
  final TextStyle formLabel;
  final TextStyle style16;
  final TextStyle bebas;

  @override
  List<Object?> get props => [title, paragraph, formLabel, style16, bebas];
}
