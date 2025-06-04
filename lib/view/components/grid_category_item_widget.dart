import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/main_category.dart';

class GridCategoryItemWidget extends StatelessWidget {
  final MainCategory category;
  final VoidCallback? onTap;

  const GridCategoryItemWidget({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Card(
        elevation: 0.5, // Subtle shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
          side: BorderSide(color: AppColors.border.withOpacity(0.5), width: 0.5),
        ),
        color: AppColors.cardBackground, // Or Colors.white
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6.r),
                  child: CachedNetworkImage(
                    imageUrl: category.imageUrl,
                    fit: BoxFit.contain, // Or BoxFit.cover, depending on image aspect ratios
                    placeholder: (context, url) => Container(
                      color: AppColors.lightGrey,
                      child: Center(
                        child: Icon(Icons.image_outlined, color: AppColors.mediumGrey, size: 30.sp),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.lightGrey,
                      child: Center(
                        child: Icon(Icons.broken_image_outlined, color: AppColors.mediumGrey, size: 30.sp),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                category.name,
                textAlign: TextAlign.center,
                style: AppFonts.bodySmall.copyWith(
                  color: AppColors.textDark, // Using textDark for better visibility
                  fontWeight: FontWeight.w500, // Slightly bolder
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
