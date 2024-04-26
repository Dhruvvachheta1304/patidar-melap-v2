import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patidar_melap_app/app/enum.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/app_theme.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.title,
    this.height,
    this.initialValue,
    this.suffixIcon,
    this.controller,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.titleTextStyle,
    this.validator,
    this.textInputType = TextInputType.text,
    this.isForPin,
    this.onChange,
    this.inputFormatters,
    this.maxLines,
    this.minLines,
    this.maxLength,
    this.obscureText = false,
    this.textCapitalization = false,
    this.readOnly,
    this.inputTextStyle,
    this.onTap,
    this.labelText,
    this.focusNode,
    this.fillColor,
    this.titleTrailingWidget,
    this.titleDescription,
    this.isError,
    this.errorText,
    this.textInputAction,
    this.borderColor,
    this.onFieldSubmitted,
    this.counterText = true,
    this.obscuringCharacter,
    this.radius,
    this.borderType = TextFieldBorder.outlinedBorder,
  });

  final String? title;
  final double? height;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final String? hintText;
  final String? initialValue;
  final TextStyle? hintStyle;
  final TextStyle? titleTextStyle;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final bool? isForPin;
  final bool obscureText;
  final ValueChanged<String>? onChange;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final bool textCapitalization;
  final bool? readOnly;
  final Color? fillColor;
  final Color? borderColor;
  final TextStyle? inputTextStyle;
  final FocusNode? focusNode;
  final Function()? onTap;
  final String? labelText;
  final Widget? titleTrailingWidget;
  final Widget? titleDescription;
  final bool? isError;
  final String? errorText;
  final bool? counterText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final String? obscuringCharacter;
  final double? radius;
  final TextFieldBorder borderType;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.labelText == null)
          const SizedBox.shrink()
        else
          Row(
            children: [
              AppText.paragraph(
                widget.labelText!,
                maxLines: 1,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              HSpace.xxsmall(),
              if (widget.titleTrailingWidget != null) widget.titleTrailingWidget!,
            ],
          ),
        if (widget.titleDescription != null)
          Column(
            children: [widget.titleDescription!, VSpace.xsmall()],
          ),
        SizedBox(
          height: widget.labelText == null ? 0 : Insets.xsmall,
        ),
        SizedBox(
          // height: widget.height ?? 60,
          child: TextFormField(
            obscuringCharacter: widget.obscuringCharacter ?? '•',
            initialValue: widget.initialValue,
            onTap: widget.onTap,
            focusNode: widget.focusNode,
            obscureText: widget.obscureText,
            textAlignVertical: TextAlignVertical.center,
            controller: widget.controller,
            cursorColor: context.colorScheme.grey500,
            readOnly: widget.readOnly ?? false,
            maxLength: widget.maxLength ?? TextField.noMaxLength,
            style: widget.inputTextStyle ??
                context.textTheme?.title.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  overflow: TextOverflow.ellipsis,
                ),
            textAlign: (widget.isForPin ?? false) ? TextAlign.center : TextAlign.start,
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: context.colorScheme.error,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              contentPadding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 5,
              ),
              counterText: (widget.counterText ?? false) ? '' : null,
              focusedBorder: widget.borderColor != null
                  ? OutlineInputBorder(
                      borderSide: BorderSide(color: widget.borderColor!),
                    )
                  : const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
              enabledBorder: widget.borderColor != null
                  ? OutlineInputBorder(borderSide: BorderSide(color: widget.borderColor!))
                  : const OutlineInputBorder(
                      borderSide: BorderSide.none,
                    ),
              errorMaxLines: 7,
              errorText: widget.errorText,
              errorBorder: getErrorBorder(widget.borderType),
              fillColor: widget.fillColor ?? context.colorScheme.textFieldFill,
              filled: true,
              isDense: true,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              prefix: Padding(
                padding: EdgeInsets.only(left: widget.prefixIcon == null ? 12 : 0.0),
              ),
              prefixIcon: widget.prefixIcon,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  context.textTheme?.title.copyWith(
                    fontSize: 15,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                    color: context.colorScheme.grey400,
                  ),
              suffixIcon: (widget.suffixIcon == null)
                  ? null
                  : Padding(
                      padding: const EdgeInsets.all(.1),
                      child: widget.suffixIcon,
                    ),
            ),
            onFieldSubmitted: widget.onFieldSubmitted,
            keyboardType: widget.textInputType,
            validator: widget.validator,
            inputFormatters: widget.inputFormatters ?? [],
            onChanged: widget.onChange,
            maxLines: widget.maxLines ?? 1,
            minLines: widget.minLines ?? 1,
            textInputAction: widget.textInputAction,
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ),
      ],
    );
  }

  InputBorder? getBorder(TextFieldBorder? borderType) {
    return switch (borderType) {
      TextFieldBorder.outlinedBorder => OutlineInputBorder(
          borderSide: widget.borderColor != null ? BorderSide(color: widget.borderColor!, width: 1) : BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.radius ?? AppTheme.radius12),
          ),
        ),
      TextFieldBorder.baseBorder => UnderlineInputBorder(
          borderSide: widget.borderColor != null ? BorderSide(color: widget.borderColor!, width: 2) : BorderSide.none,
        ),
      TextFieldBorder.none => OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(
            Radius.circular(widget.radius ?? AppTheme.radius12),
          ),
        ),
      null => null,
    };
  }

  InputBorder? getErrorBorder(TextFieldBorder? borderType) {
    switch (borderType) {
      case TextFieldBorder.outlinedBorder:
        return OutlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.danger500),
          borderRadius: BorderRadius.all(
            Radius.circular(widget.radius ?? AppTheme.radius6),
          ),
        );
      case null:
      case TextFieldBorder.baseBorder:
        return UnderlineInputBorder(
          borderSide: BorderSide(color: context.colorScheme.danger500),
        );
      case TextFieldBorder.none:
    }
    return null;
  }
}
