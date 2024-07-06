import 'package:flutter/material.dart';
import 'package:skycast/views/theme/app_pallete.dart';

// This class represents the custom theme for the app
class AppTheme {
  // The instance of the custom theme
  static final ThemeData instance = ThemeData.dark().copyWith(
    // Custom page transition theme
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    // Custom scaffold background color
    scaffoldBackgroundColor: AppPallete.backgroundColor,
    // Custom primary color
    primaryColor: AppPallete.primaryGreen.level1,
    // Custom button theme
    buttonTheme: ButtonThemeData(
      buttonColor: AppPallete.primaryGreen.level1,
      textTheme: ButtonTextTheme.primary,
    ),
    // Custom elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        // Custom icon color
        iconColor: WidgetStateProperty.all(AppPallete.primaryWhite.level4!),
        // Custom background color
        backgroundColor:
            WidgetStateProperty.all(AppPallete.primaryWhite.level1),
        // Custom padding
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        ),
      ),
    ),
  );
}
