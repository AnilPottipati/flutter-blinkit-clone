import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/product_model.dart'; // Updated import
import 'common/custom_add_to_cart_button.dart'; // New import

class HorizontalProductListWidget extends StatefulWidget {
  const HorizontalProductListWidget({super.key});

  @override
  State<HorizontalProductListWidget> createState() => _HorizontalProductListWidgetState();
}

class _HorizontalProductListWidgetState extends State<HorizontalProductListWidget> {
  Future<List<Product>>? _productsFuture; // Changed to Product model

  @override
  void initState() {
    super.initState();
    _productsFuture = _loadProducts();
  }

  Future<List<Product>> _loadProducts() async { // Changed to Product model
    final String jsonString = await rootBundle.loadString('assets/mock_data/mock_products.json');
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
    return jsonList.map((jsonItem) => Product.fromJson(jsonItem as Map<String, dynamic>)).toList(); // Changed to Product.fromJson
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _productsFuture, // Changed to Product model
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 280.h, // Adjusted height
            child: const Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
          return SizedBox(
            height: 280.h, // Adjusted height
            child: Center(child: Text('Could not load products. Error: ${snapshot.error}')), // Added error detail
          );
        }

        final products = snapshot.data!;
        return SizedBox(
          height: 280.h, // Adjusted height to accommodate CustomAddToCartButton
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            itemCount: products.length,
            separatorBuilder: (_, __) => SizedBox(width: 12.w),
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: 160.w,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
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
                  padding: EdgeInsets.all(10.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AspectRatio(
                        aspectRatio: 1.5,
                        child: Image.network(product.imageUrl ?? '', fit: BoxFit.contain, errorBuilder: (context, error, stackTrace) => const Icon(Icons.error)),
                      ),
                      SizedBox(height: 8.h),
                      Text(product.name, maxLines: 2, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp)),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Flexible(
                            child: Text("\u20B9${product.price.toStringAsFixed(0)}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp, color: Colors.green), overflow: TextOverflow.ellipsis, maxLines: 1),
                          ),
                          SizedBox(width: 6.w),
                          Flexible(
                            child: Text(product.mrp, style: TextStyle(decoration: TextDecoration.lineThrough, fontSize: 12.sp, color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(product.discount, style: TextStyle(color: Colors.orange, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      CustomAddToCartButton(product: product), // Replaced with CustomAddToCartButton
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
