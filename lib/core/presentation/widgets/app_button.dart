import 'package:flutter/material.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled,
    this.isExpanded = true,
    this.textStyle,
    this.padding,
    this.contentPadding,
    this.buttonColor,
    this.defaultTextColor,
    this.borderRadius,
    this.isOutline = false,
    this.borderColor,
    this.gradientColors,
  });

  final String text;
  final bool? isEnabled;
  final bool isExpanded;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final Color? buttonColor;
  final Color? defaultTextColor;
  final double? borderRadius;
  final bool isOutline;
  final Color? borderColor;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      key: Key(text),
      enabled: isEnabled,
      button: true,
      label: text,
      child: SizedBox(
        width: isExpanded ? double.maxFinite : null,
        child: _ButtonContent(
          text: text,
          isEnabled: isEnabled ?? false,
          isExpanded: isExpanded,
          onPressed: onPressed,
          contentPadding: contentPadding,
          textStyle: textStyle,
          borderRadius: borderRadius,
          buttonColor: buttonColor,
          defaultTextColor: defaultTextColor ?? Colors.white,
          isOutline: isOutline,
          borderColor: borderColor,
          gradientColors: gradientColors,
        ),
      ),
    );
  }
}

class _ButtonContent extends StatelessWidget {
  const _ButtonContent({
    required this.isEnabled,
    required this.text,
    required this.onPressed,
    required this.isOutline,
    this.defaultTextColor,
    this.textStyle,
    this.isExpanded = false,
    this.contentPadding,
    this.buttonColor,
    this.borderRadius,
    this.borderColor,
    this.gradientColors,
  });

  final EdgeInsets? contentPadding;
  final bool isEnabled;
  final String text;
  final TextStyle? textStyle;
  final Color? defaultTextColor;
  final bool isExpanded;
  final Color? buttonColor;
  final VoidCallback? onPressed;
  final double? borderRadius;
  final bool isOutline;
  final Color? borderColor;
  final List<Color>? gradientColors;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      color: isOutline ? Colors.black : defaultTextColor ?? Colors.white,
      fontSize: 16,
    );

    return ElevatedButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(EdgeInsets.zero),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20),
            side: isOutline ? BorderSide(color: borderColor ?? Colors.black) : BorderSide.none,
          ),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.transparent),
      ),
      onPressed: onPressed,
      child: Container(
        padding: contentPadding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          gradient: LinearGradient(
            colors: gradientColors ?? [Colors.red.shade500, Colors.purple],
          ),
          border: isOutline ? Border.all(color: borderColor ?? Colors.black) : null,
        ),
        child: Center(
          child: isEnabled
              ? Text(
                  text,
                  style: textStyle ?? defaultTextStyle,
                  textAlign: TextAlign.center,
                )
              : CircularProgressIndicator(
                  color: context.colorScheme.white,
                ),
        ),
      ),
    );
  }
}
