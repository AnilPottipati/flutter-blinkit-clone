import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/main_category.dart';
import './subcategory_item_widget.dart';

class MainCategoryCardWidget extends StatelessWidget {
  final MainCategory mainCategory;

  const MainCategoryCardWidget({super.key, required this.mainCategory});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: CachedNetworkImage(
                imageUrl: mainCategory.imageUrl,
                width: 70.w,
                height: 70.w,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  width: 70.w,
                  height: 70.w,
                  color: AppColors.lightGrey,
                  child: const Center(child: Icon(Icons.image_outlined, color: AppColors.mediumGrey)),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 70.w,
                  height: 70.w,
                  color: AppColors.lightGrey,
                  child: const Center(child: Icon(Icons.broken_image_outlined, color: AppColors.mediumGrey)),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Category Name and Subcategories
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainCategory.name,
                    style: AppFonts.title2.copyWith(fontSize: 16.sp, color: AppColors.textDark),
                  ),
                  SizedBox(height: 6.h),
                  ...mainCategory.subcategories.map((sub) {
                    return SubcategoryItemWidget(subcategoryName: sub);
                  }).toList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
