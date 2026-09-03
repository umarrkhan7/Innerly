import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.lightSurface,
      error: AppColors.error,
    ),
    textTheme: const TextTheme().apply(
      bodyColor: AppColors.lightText,
      displayColor: AppColors.lightText,
    ),
  );

  static ThemeData  darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
    ),
    textTheme: const TextTheme().apply(
      bodyColor: AppColors.darkText,
      displayColor: AppColors.darkText,
    ),
  );
}