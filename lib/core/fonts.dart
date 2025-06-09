import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

class AppFonts {
  // Font Families
  static const String primaryFont = 'Poppins';
  static const String secondaryFont = 'Roboto';

  // Text Styles
  static TextStyle get heading1 => GoogleFonts.poppins(
    fontSize: 32.sp,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get heading2 => GoogleFonts.poppins(
    fontSize: 28.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Added for HomeScreen title
  static TextStyle get title2 => GoogleFonts.poppins(
    fontSize: 22.sp, // As per previous definition attempt
    fontWeight: FontWeight.w700,
    color: AppColors.textDark, // Using the added textDark
  );

  static TextStyle get title3 => GoogleFonts.poppins(
    fontSize: 20.sp, // Slightly smaller than title2
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle get heading3 => GoogleFonts.poppins(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.roboto(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // Added for CategoryCardWidget
  static TextStyle get body1Strong => GoogleFonts.roboto(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600, // Bolder than bodyLarge
    color: AppColors.textDark, // Using the added textDark
  );

  static TextStyle get bodyMedium => GoogleFonts.roboto(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get bodySmall => GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get caption => GoogleFonts.roboto(
    fontSize: 12.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textHint,
  );
}
