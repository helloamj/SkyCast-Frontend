import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const ResponsiveText(this.text, {super.key, required this.style});

  @override
  Widget build(BuildContext context) {
    final screenWidth = min(600, MediaQuery.of(context).size.width);
    double responsiveFontSize = style.fontSize! + (screenWidth / 100);
    return Text(
      text,
      style: style.copyWith(fontSize: responsiveFontSize),
    );
  }
}
