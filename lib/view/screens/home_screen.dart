import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/controller/home_controller.dart';
import '../../data/repo/product_repo.dart';
import '../components/home_custom_sliver_app_bar.dart';
import '../../data/model/top_category.dart'; // For sampleTopCategories in SliverAppBar

// New Widget Imports
import '../components/powered_by_brands_widget.dart';
import '../components/horizontal_category_card_list.dart';
import '../components/section_header_widget.dart';
import '../components/horizontal_product_list_widget.dart';
import '../components/bestsellers_section_widget.dart';
import '../components/featured_this_week_section_widget.dart'; // Added import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeController homeController =
        Get.isRegistered<HomeController>()
            ? Get.find<HomeController>()
            : Get.put(HomeController(ProductRepo()));

    // Placeholder for brand logos - replace with your actual asset paths
    final List<String> brandLogos = [
      'https://placehold.co/80x32.png?text=Brand+1',
      'https://placehold.co/80x32.png?text=Brand+2',
      'https://placehold.co/80x32.png?text=Brand+3',
      'https://placehold.co/80x32.png?text=Brand+4',
      'https://placehold.co/80x32.png?text=Brand+5',
    ];

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await homeController.fetchProducts();
          // You might want to refresh JSON-loaded data too if it can change
          // For mock data, this is usually not necessary unless you re-trigger the futures
          setState(() {}); // Rebuild to re-trigger FutureBuilders if needed
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo is ScrollUpdateNotification || scrollInfo is ScrollEndNotification) {
              homeController.handleScroll();
            }
            return false;
          },
          child: CustomScrollView(
            controller: homeController.scrollController,
            slivers: [
              Obx(() => HomeCustomSliverAppBar(
                    backgroundColor: homeController.appBarColor.value,
                    itemColor: homeController.appBarItemColor.value,
                    searchIconColor: homeController.searchIconColor.value,
                    categoryStripItemColor: homeController.categoryStripItemColor.value,
                    expandedHeight: kToolbarHeight + 35.h + 100.h + 60.h,
                    sampleTopCategories: sampleTopCategories, // Ensure this is correctly sourced
                    onWalletPressed: () {
                      // TODO: Navigate to wallet
                    },
                    onSearchTap: () {
                      // TODO: Handle search tap
                    },
                    showCategoryStrip: true,
                  )),

              // --- New Sections Added Below ---

              // 1. Powered By Brands Row
              SliverToBoxAdapter(
                child: PoweredByBrandsWidget(brandLogos: brandLogos),
              ),

              // Optional: Add some spacing
              SliverToBoxAdapter(child: SizedBox(height: 16.h)),

              // 2. Horizontal Category Cards
              const SliverToBoxAdapter(
                child: HorizontalCategoryCardList(),
              ),

              // Optional: Add some spacing
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              // 3. Section Title: LOWEST PRICES EVER
              const SliverToBoxAdapter(
                child: SectionHeaderWidget(title: 'LOWEST PRICES EVER'),
              ),

              // 4. Horizontal Product List
              const SliverToBoxAdapter(
                child: HorizontalProductListWidget(),
              ),

              // Spacing
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              // 5. Bestsellers Section
              const BestsellersSectionWidget(),

              // Spacing
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),

              // 6. Featured This Week Section
              const FeaturedThisWeekSectionWidget(),
              
              // Add more slivers/content as needed
              SliverToBoxAdapter(child: SizedBox(height: 20.h)), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
