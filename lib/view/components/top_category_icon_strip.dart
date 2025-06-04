import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/top_category.dart';
import '../../core/fonts.dart';

class TopCategoryIconStrip extends StatelessWidget {
  final List<TopCategory> categories;

  const TopCategoryIconStrip({Key? key, required this.categories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h, // Adjust height as needed
      color: Colors.transparent, // Background for the strip, to blend with AppBar gradient
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w), // Spacing between items
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56.w, // Icon background size
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15), // Icon background color on gradient
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    category.iconData,
                    size: 28.sp,
                    color: Colors.white, // Icon color on gradient
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  category.name,
                  style: AppFonts.caption.copyWith(color: Colors.white.withOpacity(0.9), fontSize: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
