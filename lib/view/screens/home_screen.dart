import 'package:blinkit_clone/view/components/category_grid_item_widget.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';
import 'package:blinkit_clone/data/static_data/app_category_groups.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/controller/home_controller.dart';
import '../components/common/shimmer_box.dart';
import '../../data/repo/product_repo.dart';
import '../components/home_custom_sliver_app_bar.dart';
import '../../data/model/top_category.dart'; // For sampleTopCategories in SliverAppBar
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
  // Progressive loading for categories
  int _visibleCategoryCount = 0;
  Timer? _categoryLoaderTimer;
  bool _hasStartedCategoryLoader = false;

  @override
  void initState() {
    super.initState();
    // Do not auto-start loader. User must trigger it.
  }

  void _startCategoryLoader() {
    if (_hasStartedCategoryLoader) return;
    _hasStartedCategoryLoader = true;
    _visibleCategoryCount = 0;
    _categoryLoaderTimer?.cancel();
    final totalCategories =
        appCategoryGroups.expand((g) => g.categories).length;
    const int itemsPerRow = 4;
    _categoryLoaderTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_visibleCategoryCount < totalCategories) {
          _visibleCategoryCount += itemsPerRow;
          if (_visibleCategoryCount > totalCategories) {
            _visibleCategoryCount = totalCategories;
          }
        }
        if (_visibleCategoryCount >= totalCategories) {
          timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _categoryLoaderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController =
        Get.isRegistered<HomeController>()
            ? Get.find<HomeController>()
            : Get.put(HomeController(ProductRepo()));

    // Progressive loading logic for categories
    final allCategories =
        appCategoryGroups.expand((g) => g.categories).toList();
    final int categoriesToDisplay = _visibleCategoryCount.clamp(
      0,
      allCategories.length,
    );
    final List visibleCategories =
        allCategories.take(categoriesToDisplay).toList();

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
          if (mounted) {
            setState(() {}); // Rebuild to re-trigger FutureBuilders if needed
          }
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 50 && !_hasStartedCategoryLoader) {
              _startCategoryLoader();
            }
            if (scrollInfo is ScrollUpdateNotification ||
                scrollInfo is ScrollEndNotification) {
              homeController.handleScroll();
            }
            return false;
          },
          child: Obx(() {
            if (homeController.isLoading.value) {
              // Show shimmer placeholders while loading
              return ListView(
                children: [
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ShimmerBox(
                      width: double.infinity,
                      height: 180.h,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  SizedBox(
                    height: 240.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      separatorBuilder: (_, __) => SizedBox(width: 12.w),
                      itemBuilder:
                          (_, __) => ShimmerBox(
                            width: 160.w,
                            height: 220.h,
                            borderRadius: BorderRadius.circular(16),
                          ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: ShimmerBox(
                      width: double.infinity,
                      height: 40.h,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  SizedBox(height: 12.h),
                  SizedBox(
                    height: 120.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      separatorBuilder: (_, __) => SizedBox(width: 10.w),
                      itemBuilder:
                          (_, __) => ShimmerBox(
                            width: 100.w,
                            height: 100.h,
                            borderRadius: BorderRadius.circular(12),
                          ),
                    ),
                  ),
                ],
              );
            }
            return CustomScrollView(
              controller: homeController.scrollController,
              slivers: [
                Obx(
                  () => HomeCustomSliverAppBar(
                    backgroundColor: homeController.appBarColor.value,
                    itemColor: homeController.appBarItemColor.value,
                    searchIconColor: homeController.searchIconColor.value,
                    categoryStripItemColor:
                        homeController.categoryStripItemColor.value,
                    expandedHeight: kToolbarHeight + 35.h + 100.h + 60.h,
                    sampleTopCategories:
                        sampleTopCategories, // Ensure this is correctly sourced
                    onWalletPressed: () {
                      // TODO: Navigate to wallet
                    },
                    onSearchTap: () {
                      // TODO: Handle search tap
                    },
                    showCategoryStrip: true,
                  ),
                ),

                // --- New Sections Added Below ---

                // 1. Powered By Brands Row
                SliverToBoxAdapter(
                  child: PoweredByBrandsWidget(brandLogos: brandLogos),
                ),

                // Optional: Add some spacing
                SliverToBoxAdapter(child: SizedBox(height: 16.h)),

                // 2. Horizontal Category Cards
                const SliverToBoxAdapter(child: HorizontalCategoryCardList()),

                // Optional: Add some spacing
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                // 3. Section Title: LOWEST PRICES EVER
                const SliverToBoxAdapter(
                  child: SectionHeaderWidget(title: 'LOWEST PRICES EVER'),
                ),

                // 4. Horizontal Product List
                const SliverToBoxAdapter(child: HorizontalProductListWidget()),

                // Spacing
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                // 5. Bestsellers Section
                const BestsellersSectionWidget(),

                // Spacing
                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                // 6. Featured This Week Section
                const FeaturedThisWeekSectionWidget(),

                SliverToBoxAdapter(child: SizedBox(height: 20.h)),

                // 7. All Categories Section
                if (appCategoryGroups.isNotEmpty) ...[
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 16.w,
                        right: 16.w,
                        top: 24.h,
                        bottom: 12.h,
                      ),
                      child: Text(
                        'All Categories',
                        style: AppFonts.title2.copyWith(
                          fontSize: 18.sp,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                  ),
                  if (_visibleCategoryCount > 0)
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 8.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.75,
                        ),
                        delegate: SliverChildBuilderDelegate((
                          BuildContext context,
                          int index,
                        ) {
                          final category = visibleCategories[index];
                          return CategoryGridItemWidget(category: category);
                        }, childCount: visibleCategories.length),
                      ),
                    ),
                  if (_visibleCategoryCount < allCategories.length)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 24.h),
                        child: Center(
                          child: SizedBox(
                            width: 32.w,
                            height: 32.w,
                            child: CircularProgressIndicator(strokeWidth: 3),
                          ),
                        ),
                      ),
                    ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: 20.h),
                  ), // Bottom padding
                ],
              ],
            );
          }),
        ),
      ),
    );
  }
}
