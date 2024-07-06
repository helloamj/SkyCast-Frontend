import 'package:flutter/material.dart';
import 'package:skycast/views/global/responsive_text_widget.dart';

class WeatherRow extends StatelessWidget {
  final String imagePath; // The path to the weather icon image
  final String label; // The label for the weather information
  final String value; // The value for the weather information

  const WeatherRow({
    required this.imagePath,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imagePath, // Display the weather icon image
          scale: 8, // Scale the image to a smaller size
        ),
        const SizedBox(
            width: 5), // Add a small gap between the image and the text
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveText(
              label, // Display the weather information label
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
            const SizedBox(
                height: 3), // Add a small gap between the label and the value
            ResponsiveText(
              value, // Display the weather information value
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
