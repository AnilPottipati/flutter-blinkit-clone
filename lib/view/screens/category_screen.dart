import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/view/components/home_custom_sliver_app_bar.dart';
import 'package:blinkit_clone/view/components/category_screen_body_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          HomeCustomSliverAppBar(
            backgroundColor: AppColors.primary,
            itemColor: Colors.white,
            searchIconColor: AppColors.textHint,
            categoryStripItemColor: Colors.white, // Not visible but required
            expandedHeight: 120.h, // Adjusted for hidden category strip
            sampleTopCategories: const [], // Empty list as strip is hidden
            showCategoryStrip: false,
            onWalletPressed: () {
              // TODO: Implement wallet pressed
            },
            onSearchTap: () {
              // TODO: Implement search tap
            },
          ),
          const SliverToBoxAdapter(
            child: CategoryScreenBodyWidget(),
          ),
        ],
      ),
    );
  }
}
