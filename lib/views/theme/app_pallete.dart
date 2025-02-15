import 'dart:ui';

import 'package:flutter/material.dart';

class AppColor {
  Color level1; // First level color
  Color level2; // Second level color
  Color level3; // Third level color
  Color? level4; // Optional fourth level color
  AppColor({
    required this.level1,
    required this.level2,
    required this.level3,
    this.level4,
  });
}

class AppPallete {
  // Color definitions
  static Color onBackground =
      const Color(0xFF2A2A2A); // Color for text on background

  // Primary colors
  static AppColor primaryGreen = AppColor(
    level1: const Color(0xFF25C685),
    level2: const Color(0xFF3DD598),
    level3: const Color(0xFF286053),
  );
  static AppColor primaryOrange = AppColor(
    level1: const Color(0xFFFF8A34),
    level2: const Color(0xFFFF974A),
    level3: const Color(0xFF624D3B),
  );
  static AppColor primaryBlue = AppColor(
    level1: const Color(0xFF005DF2),
    level2: const Color(0xFF0062FF),
    level3: const Color(0xFF163E72),
  );
  static AppColor primaryRed = AppColor(
    level1: const Color(0xFFFF464F),
    level2: const Color(0xFFFF575F),
    level3: const Color(0xFF623A42),
  );
  static AppColor primaryYellow = AppColor(
    level1: const Color(0xFFFFAB40),
    level2: const Color(0xFFFFC542),
    level3: const Color(0xFF625B39),
  );
  static AppColor primaryPurple = AppColor(
    level1: const Color(0xFF6952DC),
    level2: const Color(0xFF755FE2),
    level3: const Color(0xFF393D69),
  );
  static AppColor primaryWhite = AppColor(
    level1: const Color(0xFFFFFFFF),
    level2: const Color(0xFFE4E9F3),
    level3: const Color(0xFF979797),
    level4: const Color(0xFF1A3B34),
  );

  // Gradients
  static LinearGradient primaryGreenGradient = LinearGradient(
    colors: [primaryGreen.level1, primaryGreen.level2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryOrangeGradient = LinearGradient(
    colors: [primaryOrange.level1, primaryOrange.level2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryBlueGradient = LinearGradient(
    colors: [primaryBlue.level1, primaryBlue.level2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryPurpleGradient = LinearGradient(
    colors: [primaryPurple.level1, primaryPurple.level2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient backgroundGradient = LinearGradient(
    colors: [
      Color(0XFFcfc7f8),
      Color(0XFFd9afd9),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryRedGradient = const LinearGradient(
    tileMode: TileMode.mirror,
    colors: [
      Color(0XFFF07470),
      Color(0XFFEA4C46),
      Color(0XFFDC1C13),
      Color(0XFFEA4C46),
      Color(0XFFF07470),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryBlackGradient = const LinearGradient(
    tileMode: TileMode.mirror,
    colors: [
      Color(0XFF040404),
      Color(0XFF000000),
      Color(0XFF646464),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryBackgrondGradient = const LinearGradient(
    tileMode: TileMode.mirror,
    colors: [
      Color(0XFF22343C),
      Color(0XFF1F2E35),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static LinearGradient primaryYellowGradient = LinearGradient(
    colors: [primaryYellow.level1, primaryYellow.level2],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Color backgroundColor = Colors.black; // Background color
}
