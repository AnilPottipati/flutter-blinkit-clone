import 'package:get/get.dart';
import '../model/category.dart';
import '../repo/category_repo.dart';

class CategoryController extends GetxController {
  final CategoryRepo _categoryRepo = CategoryRepo(); // Instantiate the repo

  // Observable list for categories
  var categories = <Category>[].obs;
  // Observable for loading state
  var isLoading = true.obs;
  // Observable for error state/message
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories(); // fetchCategories is async but onInit is sync, so no await here.
                     // GetX handles the Future internally for onInit.
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      errorMessage(''); // Clear previous error
      var fetchedCategories = await _categoryRepo.getCategories();
      categories.assignAll(fetchedCategories);
    } catch (e) {
      print('Error in CategoryController fetching categories: $e');
      errorMessage('Failed to load categories. Please try again.');
      // categories.clear(); // Optionally clear categories on error
    } finally {
      isLoading(false);
    }
  }
}
