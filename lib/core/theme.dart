import 'package:flutter/material.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.scaffoldBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.background,
        surface: AppColors.cardBackground,
        error: AppColors.error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onBackground: AppColors.textPrimary,
        onSurface: AppColors.textPrimary,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.5,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textDark,
        titleTextStyle: AppFonts.title2.copyWith(color: AppColors.textDark, fontSize: 18),
      ),
      textTheme: TextTheme(
        bodyLarge: AppFonts.bodyLarge,
        bodyMedium: AppFonts.bodyMedium,
        bodySmall: AppFonts.bodySmall,
        titleLarge: AppFonts.heading1,
        titleMedium: AppFonts.heading2,
        titleSmall: AppFonts.heading3,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppFonts.bodyLarge.copyWith(fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

}
