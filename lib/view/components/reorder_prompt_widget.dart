import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';

class ReorderPromptWidget extends StatelessWidget {
  const ReorderPromptWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/reorder_illustration.png',
            height: 150.h, 
            fit: BoxFit.contain,
          ),
          SizedBox(height: 16.h),
          Text(
            'Reordering will be easy',
            style: AppFonts.title2.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8.h),
          Text(
            'Items you order will show up here so you can buy them again easily',
            style: AppFonts.bodyMedium.copyWith(color: AppColors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
