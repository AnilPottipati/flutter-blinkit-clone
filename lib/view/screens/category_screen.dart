import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';
import 'package:blinkit_clone/view/components/category_grid_item_widget.dart';
import 'package:blinkit_clone/view/components/home_custom_sliver_app_bar.dart';
import 'package:blinkit_clone/data/static_data/app_category_groups.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const String routeName =
      '/categories'; // Optional: if you need named routing

  @override
  Widget build(BuildContext context) {
    print(
      'Building CategoriesScreen. Number of category groups: ${appCategoryGroups.length}',
    );
    if (appCategoryGroups.isNotEmpty) {
      print(
        'First group title: ${appCategoryGroups.first.title}, categories: ${appCategoryGroups.first.categories.length}',
      );
    }
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: <Widget>[
          // Re-add the HomeCustomSliverAppBar as it was
          HomeCustomSliverAppBar(
            backgroundColor: AppColors.primary, // Example color
            itemColor: Colors.white,
            searchIconColor: AppColors.textHint,
            categoryStripItemColor:
                Colors.white, // Not visible but required by the component
            expandedHeight:
                120.h, // Adjust as needed, similar to your old CategoryScreen
            sampleTopCategories:
                const [], // Empty list as strip is hidden or not used here
            showCategoryStrip:
                false, // Assuming you don't want the top category strip here
            onWalletPressed: () {
              // TODO: Implement wallet pressed
            },
            onSearchTap: () {
              // TODO: Implement search tap
            },
          ),
          // Iterate over category groups to create sections
          ...appCategoryGroups.expand((group) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w,
                    top: 24.h,
                    bottom: 12.h,
                  ),
                  child: Text(
                    group.title,
                    style: AppFonts.title2.copyWith(
                      fontSize: 18.sp,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of items per row
                    crossAxisSpacing: 8.w, // Horizontal spacing
                    mainAxisSpacing: 12.h, // Vertical spacing
                    childAspectRatio:
                        0.75, // Adjust for desired item proportions (width/height)
                  ),
                  delegate: SliverChildBuilderDelegate((
                    BuildContext context,
                    int index,
                  ) {
                    final category = group.categories[index];
                    return CategoryGridItemWidget(category: category);
                  }, childCount: group.categories.length),
                ),
              ),
            ];
          }).toList(),
          SliverToBoxAdapter(
            child: SizedBox(height: 20.h),
          ), // Overall padding at the bottom
        ],
      ),
    );
  }
}
