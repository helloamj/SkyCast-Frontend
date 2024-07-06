import 'dart:math';

import 'package:flutter/material.dart';

class ResponsiveText extends StatelessWidget {
  final String text;
  final TextStyle style;

  // Constructor for the ResponsiveText widget
  const ResponsiveText(this.text, {Key? key, required this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the minimum value between 600 and the screen width
    final screenWidth = min(600, MediaQuery.of(context).size.width);

    // Calculate the responsive font size based on the screen width
    double responsiveFontSize = style.fontSize! + (screenWidth / 100);

    // Return a Text widget with the provided text and the style
    // updated with the responsive font size
    return Text(
      text,
      style: style.copyWith(fontSize: responsiveFontSize),
    );
  }
}
