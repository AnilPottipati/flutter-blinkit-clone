import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/product.dart';

class ProductRepo {
  Future<List<Product>> getProducts() async {
    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Load products from the JSON asset
    try {
      final String jsonString = await rootBundle.loadString('assets/mock_data/products.json');
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList
          .map((jsonItem) => Product.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If loading fails, return an empty list or throw an exception
      // print('Error loading products: $e');
      return [];
    }
  }
}

