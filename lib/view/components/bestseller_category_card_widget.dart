import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/bestseller_category_model.dart';

class BestsellerCategoryCardWidget extends StatelessWidget {
  final BestsellerCategory category;
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
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 2x2 Image Grid
            Expanded(
              flex: 3, // Adjust flex ratio if needed for better image vs text balance
              child: Padding(
                padding: EdgeInsets.all(8.w),
                child: GridView.builder(
                  itemCount: category.imageUrls.length, // Should be 4 as per model assertion
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 6.w,
                    mainAxisSpacing: 6.h,
                    childAspectRatio: 1, // For square images
                  ),
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.r),
                      child: CachedNetworkImage(
                        imageUrl: category.imageUrls[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.lightGrey.withOpacity(0.5),
                          child: Center(child: Icon(Icons.image_outlined, color: AppColors.mediumGrey.withOpacity(0.7), size: 20.sp)),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: AppColors.lightGrey.withOpacity(0.3),
                          child: Center(child: Icon(Icons.broken_image_outlined, color: AppColors.mediumGrey, size: 20.sp)),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Category Name and More Count
            Padding(
              padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.h, top: 4.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: AppFonts.body1Strong.copyWith(fontSize: 13.sp, color: AppColors.textDark),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '+${category.moreCount} more', // Corrected to use moreCount
                    style: AppFonts.caption.copyWith(fontSize: 11.sp, color: AppColors.textMedium),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
