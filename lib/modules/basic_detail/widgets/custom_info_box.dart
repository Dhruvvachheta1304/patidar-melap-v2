import 'package:flutter/material.dart';

class CustomInfoBox extends StatelessWidget {
  const CustomInfoBox({
    super.key,
    this.widget,
    this.color,
  });

  final Widget? widget;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: widget,
    );
  }
}
