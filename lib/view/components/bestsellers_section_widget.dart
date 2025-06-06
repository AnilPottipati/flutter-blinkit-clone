import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/product_item.dart';
import './bestseller_item_card_widget.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';

class BestsellersSectionWidget extends StatelessWidget {
  final List<ProductItem> bestsellerProducts;

  const BestsellersSectionWidget({super.key, required this.bestsellerProducts});

  @override
  Widget build(BuildContext context) {
    if (bestsellerProducts.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
      ).copyWith(top: 20.h, bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              'Bestsellers',
              style: AppFonts.title2.copyWith(
                color: AppColors.textDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: bestsellerProducts.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 12.h,
              childAspectRatio:
                  0.375, // Increased from 0.375 after removing delivery time from card content.
            ),
            itemBuilder: (context, index) {
              final product = bestsellerProducts[index];
              return BestsellerItemCardWidget(
                product: product,
                onAddTap: () {
                  // TODO: Implement add to cart functionality
                },
                onViewRecipesTap: () {
                  // TODO: Implement view recipes functionality
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
