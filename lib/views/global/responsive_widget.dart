import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile; // Widget to be displayed on mobile devices
  final Widget? tablet; // Widget to be displayed on tablet devices (optional)

  const ResponsiveWidget({super.key, required this.mobile, this.tablet});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // If the device width is less than 600 pixels
          return mobile; // Display the mobile widget
        } else {
          return tablet ??
              mobile; // If tablet widget is provided, display it. Otherwise, display the mobile widget.
        }
      },
    );
  }
}
