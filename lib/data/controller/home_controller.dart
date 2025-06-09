import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/colors.dart';
import '../model/product.dart';
import '../repo/product_repo.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  final ProductRepo _productRepo;
  
  HomeController(this._productRepo);
  
  final RxList<Product> products = <Product>[].obs;
  final RxBool isLoading = true.obs;

  // Scroll and Animation related properties
  late ScrollController scrollController;
  late AnimationController colorAnimationController;
  late Animation<Color?> colorTweenAnimation;

  final Rx<Color> appBarColor = AppColors.primary.obs;
  final Rx<Color> appBarItemColor = Colors.white.obs;
  final Rx<Color> searchIconColor = AppColors.textHintDarkBg.obs;
  final Rx<Color> categoryStripItemColor = Colors.white.obs;

  final double _scrollThreshold = 100.0; // Adjust as needed

  @override
  void onInit() {
    super.onInit();
    fetchProducts();

    scrollController = ScrollController();
    // No need to add listener here, HomeScreen will use NotificationListener

    colorAnimationController = AnimationController(
      vsync: this, // Use 'this' because of GetSingleTickerProviderStateMixin
      duration: const Duration(milliseconds: 200),
    );

    colorTweenAnimation = ColorTween(
      begin: AppColors.primary,
      end: AppColors.background, // Or Colors.white if that's the target
    ).animate(colorAnimationController)
      ..addListener(() {
        appBarColor.value = colorTweenAnimation.value ?? AppColors.primary;
      });
  }
  
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      final result = await _productRepo.getProducts();
      products.assignAll(result);
    } catch (e) {
      // Handle error
      // print('Error fetching products: $e');
    } finally {
      isLoading(false);
    }
  }

  void handleScroll() {
    if (!scrollController.hasClients) return;
    final offset = scrollController.offset;

    bool shouldBeCollapsed = offset > _scrollThreshold;

    if (shouldBeCollapsed) {
      if (colorAnimationController.status != AnimationStatus.completed &&
          colorAnimationController.status != AnimationStatus.forward) {
        colorAnimationController.forward();
      }
      if (appBarItemColor.value != AppColors.textDark) {
        appBarItemColor.value = AppColors.textDark;
        searchIconColor.value = AppColors.textMedium;
        categoryStripItemColor.value = AppColors.primary; // Or AppColors.textDark
      }
    } else {
      // Should be expanded
      if (colorAnimationController.status != AnimationStatus.dismissed &&
          colorAnimationController.status != AnimationStatus.reverse) {
        colorAnimationController.reverse();
      }
      if (appBarItemColor.value != Colors.white) {
        appBarItemColor.value = Colors.white;
        searchIconColor.value = AppColors.textHintDarkBg;
        categoryStripItemColor.value = Colors.white;
      }
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    colorAnimationController.dispose();
    super.onClose();
  }
}
