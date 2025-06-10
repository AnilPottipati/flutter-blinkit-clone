import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeaderWidget extends StatelessWidget {
  final String title;
  const SectionHeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Icon(Icons.flash_on, color: Colors.amber, size: 22.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
              letterSpacing: 0.5,
            ),
          ), // Closes Text
          ), // Closes Expanded

        ],
      ),
    );
  }
}
