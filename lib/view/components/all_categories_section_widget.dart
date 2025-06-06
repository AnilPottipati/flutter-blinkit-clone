import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
 
import '../../data/static_data/app_main_categories.dart'; 
import './grid_category_item_widget.dart';

class AllCategoriesSectionWidget extends StatelessWidget {
  const AllCategoriesSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    if (appCategoryGroups.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
        child: Center(
          child: Text(
            'No categories to display.',
            style: AppFonts.bodyLarge.copyWith(color: AppColors.textSecondary),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: appCategoryGroups.length,
      itemBuilder: (context, groupIndex) {
        final group = appCategoryGroups[groupIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 16.w, top: 16.h, bottom: 12.h, right: 16.w),
              child: Text(
                group.title,
                style: AppFonts.title2,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: group.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, 
                  childAspectRatio: 0.85, 
                  mainAxisSpacing: 8.w,
                  crossAxisSpacing: 8.w,
                ),
                itemBuilder: (context, categoryIndex) {
                  final category = group.categories[categoryIndex];
                  return GridCategoryItemWidget(
                    category: category,
                    onTap: () {
                      // Placeholder for navigation or action
                      // print('Tapped on ${category.name} in group ${group.title}');
                    },
                  );
                },
              ),
            ),
            if (groupIndex < appCategoryGroups.length - 1)
              SizedBox(height: 16.h), 
          ],
        );
      },
    );
  }
}
