import 'package:blinkit_clone/data/model/main_category.dart';

// Data model for a group of categories (e.g., "Grocery & Kitchen")
class CategoryGroup {
  final String title;
  final List<MainCategory> categories;

  CategoryGroup({required this.title, required this.categories});
}

// Sample data - replace with your actual data source and image URLs
final List<CategoryGroup> appCategoryGroups = [
  CategoryGroup(
    title: 'Grocery & Kitchen',
    categories: [
      MainCategory(name: 'Vegetables & Fruits', imageUrl: 'https://via.placeholder.com/150/92C952', subcategories: []),
      MainCategory(name: 'Atta, Rice & Dal', imageUrl: 'https://via.placeholder.com/150/771796', subcategories: []),
      MainCategory(name: 'Oil, Ghee & Masala', imageUrl: 'https://via.placeholder.com/150/24A7DB', subcategories: []),
      MainCategory(name: 'Dairy, Bread & Eggs', imageUrl: 'https://via.placeholder.com/150/5018B3', subcategories: []),
      MainCategory(name: 'Bakery & Biscuits', imageUrl: 'https://via.placeholder.com/150/F9A825', subcategories: []),
      MainCategory(name: 'Dry Fruits & Cereals', imageUrl: 'https://via.placeholder.com/150/D81B60', subcategories: []),
      MainCategory(name: 'Chicken, Meat & Fish', imageUrl: 'https://via.placeholder.com/150/00ACC1', subcategories: []),
      MainCategory(name: 'Kitchenware & Appliances', imageUrl: 'https://via.placeholder.com/150/E53935', subcategories: []),
    ],
  ),
  CategoryGroup(
    title: 'Snacks & Drinks',
    categories: [
      MainCategory(name: 'Chips & Namkeen', imageUrl: 'https://via.placeholder.com/150/3949AB', subcategories: []),
      MainCategory(name: 'Sweets & Chocolates', imageUrl: 'https://via.placeholder.com/150/8E24AA', subcategories: []),
      MainCategory(name: 'Drinks & Juices', imageUrl: 'https://via.placeholder.com/150/039BE5', subcategories: []),
      MainCategory(name: 'Tea, Coffee & Milk Drinks', imageUrl: 'https://via.placeholder.com/150/C0CA33', subcategories: []),
      MainCategory(name: 'Instant Food', imageUrl: 'https://via.placeholder.com/150/FB8C00', subcategories: []),
      MainCategory(name: 'Sauces & Spreads', imageUrl: 'https://via.placeholder.com/150/43A047', subcategories: []),
      MainCategory(name: 'Paan Corner', imageUrl: 'https://via.placeholder.com/150/6D4C41', subcategories: []),
      MainCategory(name: 'Ice Creams & More', imageUrl: 'https://via.placeholder.com/150/F06292', subcategories: []),
    ],
  ),
];
