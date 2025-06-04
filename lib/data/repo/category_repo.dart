import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/category.dart';

class CategoryRepo {
  Future<List<Category>> getCategories() async {
    try {
      // Load the JSON string from the assets
      final String response = await rootBundle.loadString('assets/categories.json');
      // Decode the JSON string into a List<dynamic>
      final List<dynamic> data = json.decode(response) as List<dynamic>;
      // Map the list of dynamic objects to a list of Category objects
      return data.map((json) => Category.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      // If anything goes wrong, throw an exception
      // In a real app, you might want more sophisticated error handling
      print('Error loading categories: $e');
      throw Exception('Failed to load categories: $e');
    }
  }
}
