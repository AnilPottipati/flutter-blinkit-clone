import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryCardData {
  final String imageUrl;
  final String title;
  final String subtitle;
  CategoryCardData({required this.imageUrl, required this.title, required this.subtitle});

  factory CategoryCardData.fromJson(Map<String, dynamic> json) {
    return CategoryCardData(
      imageUrl: json['imageUrl'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
    );
  }
}

class HorizontalCategoryCardList extends StatefulWidget {
  const HorizontalCategoryCardList({super.key});

  @override
  State<HorizontalCategoryCardList> createState() => _HorizontalCategoryCardListState();
}

class _HorizontalCategoryCardListState extends State<HorizontalCategoryCardList> {
  Future<List<CategoryCardData>>? _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = _loadCategories();
  }

  Future<List<CategoryCardData>> _loadCategories() async {
    final String jsonString = await rootBundle.loadString('assets/mock_data/mock_categories.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList.map((jsonItem) => CategoryCardData.fromJson(jsonItem as Map<String, dynamic>)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CategoryCardData>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 160.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(
            height: 160.h,
            child: const Center(child: Text('Could not load categories.')),
          );
        }

        final categories = snapshot.data!;
        return SizedBox(
          height: 160.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: categories.length,
            separatorBuilder: (_, __) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final cat = categories[index];
              return Container(
                width: 140.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Image.network(
                          cat.imageUrl,
                          height: 60.h,
                          width: 100.w,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error, size: 40),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(cat.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp), maxLines: 1, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 4.h),
                      Text(cat.subtitle, style: TextStyle(fontSize: 12.sp, color: Colors.grey[700]), maxLines: 1, overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
