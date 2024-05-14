import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patidar_melap_app/app/helpers/extensions/extensions.dart';
import 'package:patidar_melap_app/app/theme/text.dart';

class CustomProfileTabs extends StatefulWidget {
  const CustomProfileTabs({super.key, this.text, this.onTap, this.disableColor});

  final String? text;
  final VoidCallback? onTap;
  final bool? disableColor;

  @override
  State<CustomProfileTabs> createState() => _CustomProfileTabsState();
}

class _CustomProfileTabsState extends State<CustomProfileTabs> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: widget.disableColor!
              ? LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.pink.shade600,
                  ],
                )
              : LinearGradient(
                  colors: [
                    context.colorScheme.grey100,
                    context.colorScheme.grey100,
                  ],
                ),
        ),
        height: 50,
        margin: const EdgeInsets.only(
          bottom: 10,
          left: 20,
          right: 20,
        ),
        child: ListTile(
          dense: true,
          // contentPadding: EdgeInsets.all(3),
          onTap: widget.onTap,
          tileColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          trailing: Icon(
            CupertinoIcons.right_chevron,
            color: widget.disableColor! ? context.colorScheme.white : context.colorScheme.black,
            size: 25,
          ),
          title: AppText.muktaVaani(
            widget.text ?? '',
            color: widget.disableColor! ? context.colorScheme.white : context.colorScheme.black,
          ),
        ),
      ),
    );
  }
}
