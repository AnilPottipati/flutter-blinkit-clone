import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import '../model/featured_item.dart';

class FeaturedController extends GetxController {
  var featuredItems = <FeaturedItem>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeaturedItems();
  }

  Future<void> fetchFeaturedItems() async {
    try {
      isLoading(true);
      final String response = await rootBundle.loadString('assets/featured_items.json');
      final List<dynamic> data = json.decode(response) as List<dynamic>;
      featuredItems.value = data.map((json) => FeaturedItem.fromJson(json as Map<String, dynamic>)).toList();
    } catch (e) {
      // print('Error loading featured items: $e'); // Consider using a logger
      Get.snackbar('Error', 'Could not load featured items: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
