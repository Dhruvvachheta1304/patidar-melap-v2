import 'package:flutter/material.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/spacing.dart';
import 'package:patidar_melap_app/app/theme/text.dart';
import 'package:patidar_melap_app/core/presentation/widgets/app_button.dart';

typedef OnAction = void Function(DialogAction action);
typedef OnCancel = void Function();

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    required this.content,
    super.key,
    this.title,
    this.positiveText,
    this.negativeText,
    this.showAction = true,
    this.onAction,
    this.allowClosing = true,
    this.onCancel,
    this.isReverseButton = true,
    this.isEnabled = true,
    this.buttonColor,
  });

  final String? title;
  final String? content;
  final String? positiveText;
  final String? negativeText;
  final bool showAction;
  final bool isEnabled;
  final OnAction? onAction;
  final OnCancel? onCancel;
  final bool allowClosing;
  final bool isReverseButton;
  final Color? buttonColor;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      surfaceTintColor: context.colorScheme.white,
      backgroundColor: context.colorScheme.white,
      alignment: Alignment.center,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      //////title//////
      title: title != null
          ? AppText.title(
              textAlign: TextAlign.center,
              title ?? '',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: context.colorScheme.black,
            )
          : null,
      titleTextStyle: context.textTheme?.title.copyWith(
        color: context.colorScheme.black,
      ),
      actionsPadding: const EdgeInsets.only(bottom: 20),
      titlePadding: title != null
          ? const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
            )
          : EdgeInsets.zero,
      //////content//////
      content: AppText(
        content ?? '',
        fontSize: 14,
        color: context.colorScheme.grey700,
        textAlign: TextAlign.center,
      ),

      contentPadding: EdgeInsets.only(
        left: Insets.small,
        right: Insets.small,
        top: title != null ? Insets.small : Insets.small,
        bottom: Insets.small,
      ),
      //////actions//////
      actions: [
        _getActions(context),
      ],
    );
  }

  Widget _getActions(BuildContext context) {
    // if (!showAction) return Container();

    final actions = <Widget>[];
    if (positiveText?.isEmpty ?? true) {
      throw ArgumentError('positiveText can\'t be null');
    }
    actions
      ..add(HSpace.small())
      ..add(
        Expanded(
          child: AppButton(
            contentPadding: const EdgeInsets.all(10),
            buttonColor: buttonColor ?? context.colorScheme.primaryColor,
            isEnabled: isEnabled,
            text: positiveText ?? '',
            textStyle: context.textTheme?.title.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: context.colorScheme.background,
            ),
            onPressed: () {
              onAction?.call(DialogAction.positive);
            },
            isExpanded: false,
          ),
        ),
      );
    if (negativeText?.isNotEmpty ?? false) {
      actions
        ..add(HSpace.small())
        ..add(
          Expanded(
            child: AppButton(
              contentPadding: const EdgeInsets.all(10),
              isEnabled: isEnabled,
              textStyle: context.textTheme?.title.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: context.colorScheme.background,
              ),
              borderColor: context.colorScheme.background,
              text: negativeText ?? '',
              onPressed: () {
                onAction?.call(DialogAction.negative);
              },
              isExpanded: false,
            ),
          ),
        )
        ..add(HSpace.small());
    }

    if (positiveText?.isEmpty ?? true) {
      throw ArgumentError('positiveText can\'t be null');
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: isReverseButton ? actions.reversed.toList() : actions,
    );
  }
}

enum DialogAction {
  /// Indicates positive action
  positive,

  /// Indicates negative action
  negative,
}
