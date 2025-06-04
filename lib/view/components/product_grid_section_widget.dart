import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart'; // Removed unused import
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/category.dart'; // Import Category model
import './bestseller_category_card_widget.dart'; // Import the bestseller card widget

class ProductGridSectionWidget extends StatelessWidget {
  final String sectionTitle;
  final List<Category> categoriesToShow;
  final bool
  isLoading; // Optional: to show loading state if categories are being fetched by parent
  final String? errorMessage; // Optional: to show error message

  const ProductGridSectionWidget({
    super.key,
    required this.sectionTitle,
    required this.categoriesToShow,
    this.isLoading = false, // Default to false
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            sectionTitle,
            style: AppFonts.title2.copyWith(color: AppColors.textDark),
          ),
        ),
        if (isLoading)
          const Center(child: CircularProgressIndicator())
        else if (errorMessage != null && errorMessage!.isNotEmpty)
          Center(child: Text(errorMessage!))
        else if (categoriesToShow.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Center(
              child: Text(
                'No items found in this section.',
                style: AppFonts.bodyMedium,
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            // itemCount: categoriesToShow.length > 6 ? 6 : categoriesToShow.length, // Limit items if needed, or show all
            itemCount: categoriesToShow.length, // Show all passed categories
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 12.w,
              mainAxisSpacing: 12.h,
            ),
            itemBuilder: (context, index) {
              final category = categoriesToShow[index];
              return BestsellerCategoryCardWidget(
                category: category,
                onTap: () {
                  // TODO: Handle category tap, possibly navigate to a category specific page
                  // Get.to(() => CategoryScreen(categoryId: category.id));
                },
              );
            },
          ),
      ],
    );
  }
}
