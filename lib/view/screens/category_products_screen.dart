import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/main_category.dart';
import '../../data/model/product_model.dart';
import '../components/common/floating_cart_button.dart';
import '../components/product_card_widget.dart';
import '../../data/model/sub_category_model.dart';

class CategoryProductsScreen extends StatefulWidget {
  static const String routeName = '/category-products';

  const CategoryProductsScreen({super.key});

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  late final MainCategory category;
  late List<Product> sampleProducts;
  int _selectedSubCategoryIndex = 0;

  // Sample sub-category data - replace with actual data from the category
  final List<SubCategory> _subCategories = [
    SubCategory(
      name: 'All',
      imageUrl: 'https://via.placeholder.com/100/4CAF50?text=All',
    ),
    SubCategory(
      name: 'Fresh Vegetables',
      imageUrl: 'https://via.placeholder.com/100/FFC107?text=Veggies',
    ),
    SubCategory(
      name: 'Fresh Fruits',
      imageUrl: 'https://via.placeholder.com/100/FF5722?text=Fruits',
    ),
    SubCategory(
      name: 'Exotics',
      imageUrl: 'https://via.placeholder.com/100/9C27B0?text=Exotics',
    ),
    SubCategory(
      name: 'Coriander & Others',
      imageUrl: 'https://via.placeholder.com/100/8BC34A?text=Herbs',
    ),
  ];

  @override
  void initState() {
    super.initState();
    // Retrieve arguments passed from the previous screen
    category = Get.arguments as MainCategory;
    // Load sample products for the given category
    sampleProducts = _getSampleProductsForCategory(category.name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: Text(
          category.name,
          style: AppFonts.title2.copyWith(
            color: AppColors.textDark,
            fontSize: 18.sp,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.textDark),
            onPressed: () {
              /* TODO: Implement search functionality */
            },
          ),
        ],
        backgroundColor: AppColors.background,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: AppColors.textDark),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side: Sub-category navigation rail
          _buildSubCategoryNavRail(),

          // Right side: Product grid view
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.w, // More horizontal space
                mainAxisSpacing: 16.h, // More vertical space
                childAspectRatio: 0.4, // Further adjusted for taller card to fix overflow
              ),
              itemCount: sampleProducts.length,
              itemBuilder: (context, index) {
                return ProductCardWidget(product: sampleProducts[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: const FloatingCartButton(),
    );
  }

  /// Builds the navigation rail for sub-categories.
  Widget _buildSubCategoryNavRail() {
    return NavigationRail(
      selectedIndex: _selectedSubCategoryIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedSubCategoryIndex = index;
          // TODO: Add logic to filter products based on the selected sub-category
        });
      },
      minWidth: 90.w,
      labelType: NavigationRailLabelType.all,
      backgroundColor: AppColors.background,
      indicatorColor: AppColors.primary.withOpacity(0.1),
      selectedLabelTextStyle: AppFonts.bodySmall.copyWith(
        color: AppColors.primary,
        fontWeight: FontWeight.w700,
        fontSize: 11.sp,
      ),
      unselectedLabelTextStyle: AppFonts.caption.copyWith(
        color: AppColors.textMedium,
        fontSize: 11.sp,
      ),
      destinations:
          _subCategories.map((subCategory) {
            return NavigationRailDestination(
              icon: Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundColor: AppColors.lightGrey.withOpacity(0.5),
                  backgroundImage: NetworkImage(subCategory.imageUrl),
                ),
              ),
              label: Text(
                subCategory.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
    );
  }

  // Sample data - replace this with a real data source or API call
  List<Product> _getSampleProductsForCategory(String categoryName) {
    return [
      Product(
        id: '1',
        name: 'Fresh Onion',
        price: 25.00,
        mrp: '₹30',
        discount: '16% OFF',
        tag: 'Organic',
        imageUrl: 'https://via.placeholder.com/150/FFC107/000000?Text=Onion',
      ),
      Product(
        id: '2',
        name: 'Ripe Tomato',
        price: 40.00,
        mrp: '₹50',
        discount: '20% OFF',
        tag: 'Farm Fresh',
        imageUrl: 'https://via.placeholder.com/150/FF5722/FFFFFF?Text=Tomato',
      ),
      Product(
        id: '3',
        name: 'Potato',
        price: 30.00,
        mrp: '₹35',
        discount: '14% OFF',
        tag: '',
        imageUrl: 'https://via.placeholder.com/150/8D6E63/FFFFFF?Text=Potato',
      ),
      Product(
        id: '4',
        name: 'Spinach Bunch',
        price: 20.00,
        mrp: '₹25',
        discount: '20% OFF',
        tag: 'Leafy Green',
        imageUrl: 'https://via.placeholder.com/150/4CAF50/FFFFFF?Text=Spinach',
      ),
      Product(
        id: '5',
        name: 'Carrot',
        price: 50.00,
        mrp: '₹60',
        discount: '16% OFF',
        tag: 'Sweet',
        imageUrl: 'https://via.placeholder.com/150/FF9800/FFFFFF?Text=Carrot',
      ),
      Product(
        id: '6',
        name: 'Cauliflower',
        price: 35.00,
        mrp: '₹40',
        discount: '12% OFF',
        tag: '',
        imageUrl:
            'https://via.placeholder.com/150/F5F5F5/000000?Text=Cauliflower',
      ),
    ];
  }
}
