import 'package:flutter/material.dart'; // For IconData

class TopCategory {
  final String name;
  final IconData iconData;

  const TopCategory({
    required this.name,
    required this.iconData,
    // required this.iconAssetPath,
  });
}

// Sample static data for top categories
const List<TopCategory> sampleTopCategories = [
  TopCategory(name: 'All', iconData: Icons.apps),
  TopCategory(name: 'Electronics', iconData: Icons.electrical_services),
  TopCategory(name: 'Beauty', iconData: Icons.face_retouching_natural),
  TopCategory(name: 'Decor', iconData: Icons.chair),
  TopCategory(name: 'Kids', iconData: Icons.child_care),
  TopCategory(name: 'Gifting', iconData: Icons.card_giftcard),
  TopCategory(name: 'Sports', iconData: Icons.sports_soccer),
  TopCategory(name: 'Books', iconData: Icons.menu_book),
];
