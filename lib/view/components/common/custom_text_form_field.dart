import 'package:flutter/material.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixIconPressed;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FocusNode? focusNode;
  final int? maxLength;
  final TextAlign textAlign;
  final InputDecoration? decoration;
  final TextStyle? style;

  const CustomTextFormField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.onChanged,
    this.focusNode,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.decoration, // Allow full InputDecoration override
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration = decoration ?? InputDecoration(
      labelText: labelText,
      hintText: hintText,
      hintStyle: AppFonts.bodyMedium.copyWith(color: AppColors.textHint),
      labelStyle: AppFonts.bodyMedium.copyWith(color: AppColors.textSecondary),
      prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.mediumGrey) : null,
      suffixIcon: suffixIcon != null 
          ? IconButton(
              icon: Icon(suffixIcon, color: AppColors.mediumGrey),
              onPressed: onSuffixIconPressed,
            ) 
          : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.border, width: 1.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.border, width: 1.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.error, width: 1.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: AppColors.error, width: 1.5),
      ),
      filled: true,
      fillColor: AppColors.cardBackground, // Or AppColors.background based on preference
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      counterText: '', // Hide the counter if maxLength is used
    );

    return TextFormField(
      controller: controller,
      decoration: effectiveDecoration,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      focusNode: focusNode,
      maxLength: maxLength,
      textAlign: textAlign,
      style: style ?? AppFonts.bodyLarge.copyWith(color: AppColors.textPrimary),
    );
  }
}
