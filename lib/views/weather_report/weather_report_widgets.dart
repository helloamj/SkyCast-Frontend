import 'package:flutter/material.dart';
import 'package:skycast/views/global/responsive_text_widget.dart';

class WeatherRow extends StatelessWidget {
  final String imagePath;
  final String label;
  final String value;

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
          imagePath,
          scale: 8,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ResponsiveText(
              label,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 12),
            ),
            const SizedBox(height: 3),
            ResponsiveText(
              value,
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
