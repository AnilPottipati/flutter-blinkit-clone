import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../data/model/category.dart';
import '../../core/colors.dart'; // Assuming you have AppColors defined
import '../../core/fonts.dart';   // Assuming you have AppFonts defined

class CategoryCardWidget extends StatelessWidget {
  final Category category;

  const CategoryCardWidget({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ensure there are at least 4 image URLs, or use placeholders
    List<String> displayImages = List.from(category.productImageUrls);
    while (displayImages.length < 4) {
      displayImages.add('https://via.placeholder.com/80/CCCCCC/FFFFFF?Text=N/A');
    }
    displayImages = displayImages.sublist(0, 4); // Take only the first 4

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 2x2 Grid of product images
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(8.w),
              itemCount: 4, // Always 4 images
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling in grid
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: CachedNetworkImage(
                    imageUrl: displayImages[index],
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: AppColors.lightGrey),
                    errorWidget: (context, url, error) => Container(
                      color: AppColors.lightGrey,
                      child: const Icon(Icons.error_outline, color: AppColors.mediumGrey),
                    ),
                  ),
                );
              },
            ),
          ),
          // Category Name and More Items Count
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: AppFonts.body1Strong.copyWith(color: AppColors.textDark),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (category.moreItemsCount > 0) ...[
                  SizedBox(height: 2.h),
                  Text(
                    '+${category.moreItemsCount} more',
                    style: AppFonts.caption.copyWith(color: AppColors.textMedium),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
