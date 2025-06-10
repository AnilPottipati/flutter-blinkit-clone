import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/featured_item_model.dart';
import '../components/featured_item_card_widget.dart';
import '../components/section_header_widget.dart';

class FeaturedThisWeekSectionWidget extends StatefulWidget {
  const FeaturedThisWeekSectionWidget({super.key});

  @override
  State<FeaturedThisWeekSectionWidget> createState() => _FeaturedThisWeekSectionWidgetState();
}

class _FeaturedThisWeekSectionWidgetState extends State<FeaturedThisWeekSectionWidget> {
  List<FeaturedItem> _featuredItems = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFeaturedItems();
  }

  Future<void> _loadFeaturedItems() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/mock_data/mock_featured_items.json');
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      setState(() {
        _featuredItems = jsonList
            .map((jsonItem) => FeaturedItem.fromJson(jsonItem as Map<String, dynamic>))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      // print('Error loading featured items: $e');
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

    if (_featuredItems.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverList(
      delegate: SliverChildListDelegate([
        const SectionHeaderWidget(title: 'Featured this week'),
        SizedBox(height: 12.h),
        SizedBox(
          height: 180.h, // Adjust height of the horizontal list
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _featuredItems.length,
            padding: EdgeInsets.only(left: 12.w, right: 0.w), // Padding for the list
            itemBuilder: (context, index) {
              final item = _featuredItems[index];
              return FeaturedItemCardWidget(
                item: item,
                onTap: () {
                  // print('Tapped on featured item: ${item.title}');
                },
              );
            },
          ),
        ),
        SizedBox(height: 20.h), // Spacing after the section
      ]),
    );
  }
}
