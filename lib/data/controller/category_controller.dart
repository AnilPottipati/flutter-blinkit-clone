import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import '../model/category.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      errorMessage(''); // Clear previous error
      final String response = await rootBundle.loadString('assets/categories.json');
      final List<dynamic> data = json.decode(response) as List<dynamic>;
      categories.value = data.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      errorMessage('Failed to load categories: ${e.toString()}');
      // You might want to log the error to a logging service as well
      // print('Error fetching categories: $e'); 
    } finally {
      isLoading(false);
    }
  }
}
