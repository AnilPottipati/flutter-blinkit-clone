import '../model/main_category.dart';
import '../model/category_group.dart';

final List<CategoryGroup> appCategoryGroups = [
  CategoryGroup(
    title: 'Fresh & Dairy',
    categories: [
      MainCategory(
        name: 'Fruits & Vegetables',
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Fruits+%26+Vegetables',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Bakery',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Meat',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Foodgrains',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Snacks',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Beverages',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Breakfast',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Sauces',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Frozen+Food',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Cleaning',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Personal+Care',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Baby+Care',
        subcategories: [
          'Diapers & Wipes',
          'Baby Food',
          'Baby Bath & Hygiene',
          'Baby Accessories',
        ],
      ),
      MainCategory(
        name: 'Pet Care',
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Pet+Care',
        subcategories: [
          'Dog Food',
          'Cat Food',
          'Pet Accessories',
          'Grooming & Hygiene',
        ],
      ),
      MainCategory(
        name: 'Health & Wellness',
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Health',
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
        imageUrl: 'https://via.placeholder.com/100x100.png?text=Pooja+Needs',
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
