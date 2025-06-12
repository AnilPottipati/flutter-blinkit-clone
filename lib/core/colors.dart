
import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFF6B6B);
  static const Color secondary = Color(0xFF4ECDC4);
  static const Color accent = Color(0xFF3498DB);

  // Text Colors
  static const Color textPrimary = Color(0xFF333333); // Equivalent to textDark for now
  static const Color textSecondary = Color(0xFF666666); // Equivalent to textMedium for now
  static const Color textHint = Color(0xFFCCCCCC);
  static const Color textDark = Color(0xFF1A2E35); // Added for specific use
  static const Color textMedium = Color(0xFF545454); // Added for specific use


  // Background Colors
  static const Color background = Color(0xFFF5F5F5);
  static const Color cardBackground = Colors.white;
  static const Color scaffoldBackground = Colors.white;

  // Status Colors
  static const Color success = Color(0xFF2ECC71);
  static const Color error = Color(0xFFE74C3C);
  static const Color warning = Color(0xFFF1C40F);
  static const Color info = Color(0xFF3498DB);

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);
  static const Color divider = Color(0xFFE0E0E0);

  // Special Colors
  static const Color orange = Color(0xFFE57373); // For discounts
  static const Color shadow = Color(0x1A000000);
  static const Color disabled = Color(0xFFCCCCCC);

  // Added for CategoryCardWidget and HomeScreen
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color mediumGrey = Color(0xFFBDBDBD); // For icons, borders etc.
  static const Color textHintDarkBg = Color(0xFF8A8A8A); // For hint text on dark backgrounds like primary color Appbar
}
