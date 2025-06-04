import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';

class SubcategoryItemWidget extends StatelessWidget {
  final String subcategoryName;

  const SubcategoryItemWidget({super.key, required this.subcategoryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      child: Row(
        children: [
          Icon(
            Icons.circle,
            size: 6.sp,
            color: AppColors.textSecondary.withOpacity(0.6),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              subcategoryName,
              style: AppFonts.bodyMedium.copyWith(color: AppColors.textMedium, fontSize: 13.sp),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
