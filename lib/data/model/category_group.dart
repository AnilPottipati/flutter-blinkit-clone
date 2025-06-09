import '../main_category_model.dart'; // Assuming MainCategory is in the same directory or path is adjusted

class CategoryGroup {
  final String title;
  final List<MainCategory> categories;

  CategoryGroup({
    required this.title,
    required this.categories,
  });
}
