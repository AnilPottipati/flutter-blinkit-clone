import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/controller/home_controller.dart';
import '../../../data/controller/category_controller.dart'; // Added for Bestsellers
import '../../data/repo/product_repo.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
// import '../components/home_app_bar.dart'; // Replaced by SliverAppBar
import '../components/featured_section_widget.dart';
import '../components/product_grid_section_widget.dart'; // Added for Bestsellers
import '../components/all_categories_section_widget.dart'; // Added for Main Categories list
import '../../data/model/top_category.dart'; // For sampleTopCategories
// import '../components/top_category_icon_strip.dart'; // No longer directly used here
import '../components/home_custom_sliver_app_bar.dart'; // For HomeCustomSliverAppBar

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  // Color _appBarColor = AppColors.primary; // Replaced by _colorTweenAnimation.value
  Color _appBarItemColor = Colors.white;
  Color _searchIconColor = AppColors.textHintDarkBg;
  Color _categoryStripItemColor = Colors.white;

  late AnimationController _colorAnimationController;
  late Animation<Color?> _colorTweenAnimation;

  // Threshold to change color, roughly the height of the collapsible part above the main toolbar.
  // kToolbarHeight (for main app bar) + 35.h (for text section) = expandedHeight for flexible part.
  // The actual flexible part that scrolls away before pinning is about 35.h.
  // Let's set threshold slightly less than the text section's height to trigger change earlier.
  final double _scrollThreshold = 30.h; 

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _colorTweenAnimation = ColorTween(
      begin: AppColors.primary,
      end: AppColors.background,
    ).animate(_colorAnimationController)
      ..addListener(() {
        setState(() {}); // Rebuild to reflect color animation
      });
  }

  void _scrollListener() {
    bool shouldBeCollapsed = _scrollController.offset > _scrollThreshold;

    if (shouldBeCollapsed) {
      if (_colorAnimationController.status != AnimationStatus.completed && _colorAnimationController.status != AnimationStatus.forward) {
        _colorAnimationController.forward();
      }
      if (_appBarItemColor != AppColors.textDark) {
        setState(() {
          _appBarItemColor = AppColors.textDark;
          _searchIconColor = AppColors.textMedium;
          _categoryStripItemColor = AppColors.primary; // Or AppColors.textDark if better contrast
        });
      }
    } else { // Should be expanded
      if (_colorAnimationController.status != AnimationStatus.dismissed && _colorAnimationController.status != AnimationStatus.reverse) {
        _colorAnimationController.reverse();
      }
      if (_appBarItemColor != Colors.white) {
        setState(() {
          _appBarItemColor = Colors.white;
          _searchIconColor = AppColors.textHintDarkBg;
          _categoryStripItemColor = Colors.white;
        });
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    _colorAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HomeController productController =
        Get.isRegistered<HomeController>()
            ? Get.find<HomeController>()
            : Get.put(HomeController(ProductRepo()));

    final CategoryController categoryController =
        Get.isRegistered<CategoryController>()
            ? Get.find<CategoryController>()
            : Get.put(CategoryController());

    // Address data - should ideally come from a controller/state
    // TODO: Replace with actual address logic if needed

    return Scaffold(
      // appBar: const HomeAppBar(), // Replaced by SliverAppBar in CustomScrollView
      body: RefreshIndicator(
        onRefresh: () async {
          await productController.fetchProducts();
          await categoryController.fetchCategories();
        },
        child: CustomScrollView(
          controller: _scrollController, // Assign scroll controller
          slivers: [
            HomeCustomSliverAppBar(
              backgroundColor: _colorTweenAnimation.value,
              itemColor: _appBarItemColor,
              searchIconColor: _searchIconColor,
              categoryStripItemColor: _categoryStripItemColor,
              expandedHeight: kToolbarHeight + 35.h + 100.h + 60.h,
              sampleTopCategories: sampleTopCategories,
              onWalletPressed: () {
                // TODO: Navigate to wallet
              },
              onProfilePressed: () {
                // TODO: Navigate to profile
              },
              onSearchTap: () {
                // TODO: Handle search tap
              },
            ),
            // Body content starts here, converted to slivers
            SliverToBoxAdapter(
              child: SizedBox(
                height: 180.h,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withAlpha(153),
                            Colors.transparent,
                            Colors.black.withAlpha(153),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20.h,
                      left: 16.w,
                      right: 16.w,
                      child: Text(
                        'Ee sala cup namdu!',
                        textAlign: TextAlign.center,
                        style: AppFonts.heading2.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20.h),
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: Handle 'Treat yourself' button press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.accent,
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                              vertical: 14.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            elevation: 5,
                          ),
                          child: Text(
                            'Treat yourself',
                            style: AppFonts.bodyLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(
              child: Obx(() {
                if (categoryController.isLoading.value &&
                    categoryController.categories.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (categoryController.errorMessage.value.isNotEmpty &&
                    categoryController.categories.isEmpty) {
                  return Center(
                    child: Text(categoryController.errorMessage.value),
                  );
                }
                if (categoryController.categories.isEmpty) {
                  return const SizedBox.shrink();
                }
                final bestsellerCategories =
                    categoryController.categories.take(6).toList();
                return ProductGridSectionWidget(
                  sectionTitle: 'Bestsellers',
                  categoriesToShow: bestsellerCategories,
                );
              }),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(child: FeaturedSectionWidget()),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(child: AllCategoriesSectionWidget()),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
          ],
        ),
      ),
    );
  }
}
