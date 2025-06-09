import '../main_category_model.dart';
import '../model/category_group.dart';

final List<CategoryGroup> appCategoryGroups = [
  CategoryGroup(
    title: 'Fresh & Dairy',
    categories: [
      MainCategory(
        name: 'Fruits & Vegetables',
        imageUrl: 'assets/images/categories/fruits_vegetables.jpeg',
        subcategories: [
          'Fresh Vegetables',
          'Leafy Greens',
          'Organic Produce',
          'Exotic Vegetables',
          'Fresh Fruits',
          'Cut & Peeled Fruits',
          'Organic Fruits',
        ],
      ),
      MainCategory(
        name: 'Bakery, Cakes & Dairy',
        imageUrl: 'assets/images/categories/bakery_cakes_dairy.jpeg',
        subcategories: [
          'Breads & Buns',
          'Cakes & Pastries',
          'Cookies & Rusk',
          'Milk',
          'Curd & Yogurt',
          'Butter & Cheese',
          'Paneer & Cream',
        ],
      ),
      MainCategory(
        name: 'Meat, Eggs & Seafood',
        imageUrl: 'assets/images/categories/meat_eggs_seafood.jpeg',
        subcategories: [
          'Chicken',
          'Mutton',
          'Fish & Seafood',
          'Eggs',
          'Ready to Cook Meats',
          'Cold Cuts',
        ],
      ),
    ],
  ),
  CategoryGroup(
    title: 'Pantry Staples',
    categories: [
      MainCategory(
        name: 'Foodgrains, Oil & Masala',
        imageUrl: 'assets/images/categories/foodgrains_oil_masala.jpeg',
        subcategories: [
          'Atta, Flours & Sooji',
          'Rice & Rice Products',
          'Dals & Pulses',
          'Edible Oils & Ghee',
          'Salt, Sugar & Jaggery',
          'Masalas & Spices',
          'Dry Fruits',
        ],
      ),
    ],
  ),
  CategoryGroup(
    title: 'Snacks & Beverages',
    categories: [
      MainCategory(
        name: 'Snacks & Munchies',
        imageUrl: 'assets/images/categories/snacks_munchies.jpeg',
        subcategories: [
          'Chips & Namkeen',
          'Popcorn & Fryums',
          'Biscuits & Cookies',
          'Sweets',
          'Chocolates',
          'Energy Bars & Snacks',
        ],
      ),
      MainCategory(
        name: 'Beverages',
        imageUrl: 'assets/images/categories/beverages.jpeg',
        subcategories: [
          'Soft Drinks',
          'Juices',
          'Tea & Coffee',
          'Health Drinks & Supplements',
          'Energy Drinks',
          'Soda & Mixers',
          'Water',
        ],
      ),
      MainCategory(
        name: 'Breakfast & Instant Food',
        imageUrl: 'assets/images/categories/breakfast_instant_food.jpeg',
        subcategories: [
          'Cereals & Oats',
          'Instant Noodles & Pasta',
          'Breakfast Mixes',
          'Ready Meals',
          'Soups',
        ],
      ),
      MainCategory(
        name: 'Sauces & Condiments',
        imageUrl: 'assets/images/categories/sauces_condiments.jpeg',
        subcategories: [
          'Ketchup & Spreads',
          'Cooking Sauces',
          'Pickles & Chutneys',
          'Vinegar & Dressings',
          'Baking Essentials',
        ],
      ),
      MainCategory(
        name: 'Frozen Food',
        imageUrl: 'assets/images/categories/frozen_food.jpeg',
        subcategories: [
          'Ice Creams & Desserts',
          'Frozen Veg Snacks',
          'Frozen Non-Veg Snacks',
          'Ready-to-Cook Meals',
        ],
      ),
    ],
  ),
  CategoryGroup(
    title: 'Home & Personal Care',
    categories: [
      MainCategory(
        name: 'Cleaning & Household',
        imageUrl: 'assets/images/categories/cleaning_household.jpeg',
        subcategories: [
          'Dishwashing',
          'Detergents & Fabric Care',
          'Fresheners & Repellents',
          'Cleaning Tools',
          'Bathroom & Kitchen Cleaners',
          'Tissues & Disposables',
        ],
      ),
      MainCategory(
        name: 'Personal Care',
        imageUrl: 'assets/images/categories/personal_care.jpeg',
        subcategories: [
          'Hair Care',
          'Oral Care',
          'Skin Care',
          'Bath & Body',
          'Deodorants & Perfumes',
          'Men’s Grooming',
          'Women’s Hygiene',
          'Shaving Needs',
        ],
      ),
      MainCategory(
        name: 'Baby Care',
        imageUrl: 'assets/images/categories/baby_care.jpeg',
        subcategories: [
          'Diapers & Wipes',
          'Baby Food',
          'Baby Bath & Hygiene',
          'Baby Accessories',
        ],
      ),
      MainCategory(
        name: 'Pet Care',
        imageUrl: 'assets/images/categories/pet_care.jpeg',
        subcategories: [
          'Dog Food',
          'Cat Food',
          'Pet Accessories',
          'Grooming & Hygiene',
        ],
      ),
      MainCategory(
        name: 'Health & Wellness',
        imageUrl: 'assets/images/categories/health_wellness.jpeg',
        subcategories: [
          'Vitamins & Supplements',
          'First Aid',
          'Health Drinks',
          'Fitness Products',
          'Sanitary Products',
        ],
      ),
      MainCategory(
        name: 'Pooja Needs / Festive Essentials',
        imageUrl: 'assets/images/categories/pooja_needs.jpeg',
        subcategories: [
          'Agarbatti & Dhoop',
          'Camphor, Cotton Wicks',
          'Diyas & Candles',
          'Sweets & Dry Fruits',
          'Seasonal Decor',
        ],
      ),
    ],
  ),
  CategoryGroup(
    title: 'Deals & Offers',
    categories: [
      MainCategory(
        name: 'Special Offers & Deals',
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Offers',
        subcategories: [
          'Offers & Deals',
          'Best Sellers',
          'New Arrivals',
          'Under ₹99',
          'Express Delivery',
          'Organic Store',
          'Subscription Packs',
        ],
      ),
    ],
  ),
];
