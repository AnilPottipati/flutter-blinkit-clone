import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/top_category.dart';
import '../../core/fonts.dart';

class TopCategoryIconStrip extends StatelessWidget {
  final List<TopCategory> categories;
  final Function? onCategoryTap;
  final Color iconColor; // Added for dynamic color

  const TopCategoryIconStrip({
    super.key,
    required this.categories,
    this.onCategoryTap,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h, // Adjust height as needed
      color:
          Colors
              .transparent, // Background for the strip, to blend with AppBar gradient
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 8.w,
            ), // Spacing between items
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 56.w, // Icon background size
                  height: 56.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onPrimary.withAlpha(
                      38,
                    ), // Icon background color on gradient
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    category.iconData,
                    size: 28.sp,
                    color:
                        iconColor, // Use dynamic icon color (StatelessWidget)
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  category.name,
                  style: AppFonts.caption.copyWith(
                    color: iconColor.withAlpha(230),
                    fontSize: 12.sp,
                  ), // Use dynamic text color (StatelessWidget), maintain alpha
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
