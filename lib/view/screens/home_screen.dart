import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/controller/home_controller.dart';
import '../../../data/controller/category_controller.dart'; // Added
import '../../data/repo/product_repo.dart';
import '../../data/service/api_service.dart';
import '../components/product_card.dart';
import '../components/category_card_widget.dart'; // Added
import '../../core/colors.dart'; // Added
import '../../core/fonts.dart';   // Added
import '../components/home_app_bar.dart'; // Added for custom AppBar
// import '../../data/model/top_category.dart'; // No longer needed here, used in HomeAppBar

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controllers
    final HomeController productController = Get.put(HomeController(ProductRepo(ApiService())));
    final CategoryController categoryController = Get.put(CategoryController());

    return Scaffold(
      appBar: const HomeAppBar(), // Use the custom AppBar
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh both products and categories
          await productController.fetchProducts();
          await categoryController.fetchCategories();
        },
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0), // AppBar handles its own padding
          children: [
            // Banner Section
            Container(
              height: 180.h, // Adjust height as needed
              width: double.infinity,
              color: AppColors.lightGrey, // Placeholder background
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://via.placeholder.com/600x300.png/0077FF/FFFFFF?Text=Ee+Sala+Cup+Namdu!', // Placeholder banner
                    fit: BoxFit.cover,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Handle 'Treat yourself' button press
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent, // Use accent color for button
                          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.r),
                          ),
                        ),
                        child: Text(
                          'Treat yourself',
                          style: AppFonts.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h), // Spacing after banner

            // Bestsellers Categories Section - Add padding here now
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Bestsellers',
                style: AppFonts.title2.copyWith(color: AppColors.textDark),
              ),
            ),

            // Bestsellers Categories Section
            // The Padding widget above (lines 73-79) already handles this title.
            SizedBox(height: 12.h),
            Obx(() {
              if (categoryController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (categoryController.errorMessage.value.isNotEmpty) {
                return Center(child: Text(categoryController.errorMessage.value));
              }
              if (categoryController.categories.isEmpty) {
                return const Center(child: Text('No categories found.'));
              }
              return GridView.builder(
                shrinkWrap: true, // Important for GridView inside ListView
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling for this grid
                itemCount: categoryController.categories.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.85, // Adjust as needed for CategoryCardWidget
                  crossAxisSpacing: 12.w,
                  mainAxisSpacing: 12.h,
                ),
                itemBuilder: (context, index) {
                  final category = categoryController.categories[index];
                  return CategoryCardWidget(category: category);
                },
              );
            }),
            SizedBox(height: 20.h),

            // Products Section Title (Optional) - Add padding here now
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                'Featured this week', // Changed title as per image
                style: AppFonts.title2.copyWith(color: AppColors.textDark),
              ),
            ),
            SizedBox(height: 12.h),

            // Products Grid Section
            Obx(() {
              if (productController.isLoading.value && productController.products.isEmpty) {
                 // Show loading only if products are empty, to avoid jumpiness if categories load first
                return const Center(child: CircularProgressIndicator());
              }
              // No specific error handling for products here, assuming HomeController handles it or it's less critical
              if (productController.products.isEmpty && !productController.isLoading.value) {
                return const Center(child: Text('No products found.'));
              }
              return GridView.builder(
                shrinkWrap: true, // Important for GridView inside ListView
                physics: const NeverScrollableScrollPhysics(), // Disable scrolling for this grid
                padding: EdgeInsets.zero, // Padding is handled by ListView
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75, // Keep original product card aspect ratio
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: productController.products.length,
                itemBuilder: (context, index) {
                  final product = productController.products[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      // TODO: Navigate to product details
                    },
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

