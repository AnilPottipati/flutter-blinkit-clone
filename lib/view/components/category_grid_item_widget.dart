import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';
import 'package:blinkit_clone/data/main_category_model.dart';

class CategoryGridItemWidget extends StatelessWidget {
  final MainCategory category;

  const CategoryGridItemWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Clean white background
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border.withAlpha(77), width: 1), // Softer border
        boxShadow: [
          BoxShadow(
            color: AppColors.mediumGrey.withAlpha(20),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 10.h), // Adjusted padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(4.w), // Small padding around the image
                child: CachedNetworkImage(
                  imageUrl: category.imageUrl,
                  placeholder: (context, url) => Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.image_outlined, color: AppColors.mediumGrey.withAlpha(179), size: 30.sp),
                  ),
                  errorWidget: (context, url, error) => Container(
                    alignment: Alignment.center,
                    child: Icon(Icons.broken_image_outlined, color: AppColors.mediumGrey.withAlpha(179), size: 30.sp),
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 6.h), // Reduced space
            Text(
              category.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppFonts.caption.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.normal, // Changed from w500
                fontSize: 10.sp, // Slightly smaller
              ),
            ),
          ],
        ),
      ),
    );
  }
}
