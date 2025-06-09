import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/category.dart'; // Assuming Category model exists

class BestsellerCategoryCardWidget extends StatelessWidget {
  final Category category;
  final VoidCallback? onTap;

  const BestsellerCategoryCardWidget({
    super.key,
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withAlpha(26),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4, // Increased flex for the image grid section
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
                child: Container(
                  color: AppColors.lightGrey.withAlpha(77), // Light background for the grid area
                  padding: EdgeInsets.all(4.w), // Padding around the grid
                  child: GridView.builder(
                    itemCount: category.productImageUrls.length > 4 ? 4 : category.productImageUrls.length, // Show up to 4 images
                    physics: const NeverScrollableScrollPhysics(), // Grid shouldn't scroll independently
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 4.w,
                      mainAxisSpacing: 4.h,
                      childAspectRatio: 1, // Square images
                    ),
                    itemBuilder: (context, index) {
                      if (index < category.productImageUrls.length) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(8.r), // Rounded corners for individual images
                          child: CachedNetworkImage(
                            imageUrl: category.productImageUrls[index],
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: AppColors.mediumGrey.withAlpha(128),
                              child: Center(child: Icon(Icons.image_outlined, color: AppColors.textHint, size: 20.sp)),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: AppColors.mediumGrey.withAlpha(128),
                              child: Center(child: Icon(Icons.broken_image_outlined, color: AppColors.textHint, size: 20.sp)),
                            ),
                          ),
                        );
                      } else {
                        // Optional: Placeholder if less than 4 images, though itemCount logic should prevent this.
                        return Container(
                           decoration: BoxDecoration(
                             color: AppColors.mediumGrey.withAlpha(77),
                             borderRadius: BorderRadius.circular(8.r),
                           ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2, // Flex for the text section remains similar, or adjust if needed
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.name,
                      style: AppFonts.body1Strong.copyWith(fontSize: 13.sp, color: AppColors.textDark),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (category.moreItemsCount > 0) ...[
                      SizedBox(height: 2.h),
                      Text(
                        '+${category.moreItemsCount} more items',
                        style: AppFonts.caption.copyWith(fontSize: 10.sp, color: AppColors.textSecondary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
