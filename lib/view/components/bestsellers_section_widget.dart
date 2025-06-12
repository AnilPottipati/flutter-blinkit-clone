import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/bestseller_category_model.dart';
import '../components/bestseller_category_card_widget.dart';
import '../components/section_header_widget.dart'; // Assuming you have this

class BestsellersSectionWidget extends StatefulWidget {
  const BestsellersSectionWidget({super.key});

  @override
  State<BestsellersSectionWidget> createState() => _BestsellersSectionWidgetState();
}

class _BestsellersSectionWidgetState extends State<BestsellersSectionWidget> {
  List<BestsellerCategory> _bestsellerCategories = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadBestsellerCategories();
  }

  Future<void> _loadBestsellerCategories() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/mock_data/mock_bestseller_categories.json');
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      setState(() {
        _bestsellerCategories = jsonList
            .map((jsonItem) => BestsellerCategory.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      // Handle error, e.g., show a message or log
      // print('Error loading bestseller categories: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (_bestsellerCategories.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(), // Or some placeholder if needed
      );
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        const SectionHeaderWidget(title: 'Bestsellers'),
        SizedBox(height: 12.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _bestsellerCategories.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              childAspectRatio: 0.75, // Adjust as needed for card proportions
            ),
            itemBuilder: (context, index) {
              final category = _bestsellerCategories[index];
              return BestsellerCategoryCardWidget(
                category: category,
                onTap: () {
                  // Handle tap, e.g., navigate to category screen
                  // print('Tapped on ${category.name}');
                },
              );
            },
          ),
        ),
        SizedBox(height: 16.h), // Spacing after the section
      ]),
    );
  }
}
