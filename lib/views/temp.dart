import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:skycast/constants/graphic_constants.dart';
import 'package:skycast/views/global/glass_scaffold.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> lotties = [
      "1d",
      "1n",
      "2d",
      "2n",
      "3d",
      "3n",
      "04d",
      "04n",
      "09d",
      "09n",
      "10d",
      "10n",
      "11d",
      "11n",
      "13d",
      "13n",
      "50d",
      "50n",
    ];

    return GlassScaffold(
      body: ListView.builder(
        itemCount: lotties.length,
        itemBuilder: (context, index) {
          return Container(
            height: 200,
            child: Column(
              children: [
                Text(
                  lotties[index],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Flexible(
                  child: Lottie.asset(
                    GraphicConstants.weatherLottie[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
