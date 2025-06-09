import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';
import 'package:blinkit_clone/data/static_data/app_main_categories.dart';
import 'package:blinkit_clone/view/components/category_grid_item_widget.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = '/categories';
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text('All Categories', style: AppFonts.heading2.copyWith(color: AppColors.textPrimary)),
        // TODO: Implement custom search bar similar to screenshots
        // bottom: PreferredSize(
        //   preferredSize: Size.fromHeight(60.h),
        //   child: Padding(
        //     padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        //     child: TextField(
        //       decoration: InputDecoration(
        //         hintText: 'Search for atta, dal, coke and more',
        //         prefixIcon: Icon(Icons.search, color: AppColors.mediumGrey),
        //         filled: true,
        //         fillColor: AppColors.lightGrey.withOpacity(0.5),
        //         border: OutlineInputBorder(
        //           borderRadius: BorderRadius.circular(8.r),
        //           borderSide: BorderSide.none,
        //         ),
        //         contentPadding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 10.w),
        //       ),
        //     ),
        //   ),
        // ),
      ),
      body: CustomScrollView(
        slivers: appCategoryGroups.expand((group) {
          return [
            SliverPadding(
              padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 18.h, bottom: 10.h),
              sliver: SliverToBoxAdapter(
                child: Text(
                  group.title,
                  style: AppFonts.title2.copyWith(color: AppColors.textDark),
                ),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns in the grid
                  crossAxisSpacing: 10.w, // Horizontal space between items
                  mainAxisSpacing: 10.h,  // Vertical space between items
                  childAspectRatio: 0.75, // Aspect ratio of each item (width / height)
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    final category = group.categories[index];
                    return CategoryGridItemWidget(category: category);
                  },
                  childCount: group.categories.length,
                ),
              ),
            ),
          ];
        }).toList(),
      ),
    );
  }
}

