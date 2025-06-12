import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/product_model.dart';
import 'common/custom_add_button.dart';

class ProductCardWidget extends StatelessWidget {
  final Product product;

  const ProductCardWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(14.r), // More rounded
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 1,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildImageWithButton(),
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                10.w,
                8.h,
                10.w,
                10.h,
              ), // Adjusted padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (product.weight != null)
                    Text(
                      product.weight!,
                      style: AppFonts.caption.copyWith(
                        color: AppColors.textHint,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  SizedBox(height: 4.h),
                  Text(
                    product.name,
                    style: AppFonts.body1Strong.copyWith(
                      color: AppColors.textDark,
                      height: 1.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  if (product.deliveryTime != null) _buildDeliveryTime(),
                  SizedBox(height: 8.h),
                  _buildPriceInfo(),
                  SizedBox(height: 10.h),
                  if (product.recipeLink != null) _buildRecipeLink(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageWithButton() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(14.r),
          ), // Match card radius
          child: CachedNetworkImage(
            imageUrl: product.imageUrl ?? '',
            height: 125.h, // Slightly taller image
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder:
                (context, url) =>
                    Container(color: AppColors.lightGrey.withOpacity(0.5)),
            errorWidget:
                (context, url, error) => const Icon(
                  Icons.error_outline,
                  color: AppColors.mediumGrey,
                ),
          ),
        ),
        Positioned(bottom: 8.h, child: CustomAddButton(product: product)),
        if (product.tag.isNotEmpty)
          Positioned(top: 8.h, left: 8.w, child: _buildTag()),
      ],
    );
  }

  Widget _buildTag() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.15),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        product.tag,
        style: AppFonts.caption.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDeliveryTime() {
    return Row(
      children: [
        Icon(
          Icons.timer_outlined,
          size: 16.sp,
          color: AppColors.textDark,
        ), // Slightly bigger icon
        SizedBox(width: 4.w),
        Text(
          product.deliveryTime!,
          style: AppFonts.body2.copyWith(
            color: AppColors.textDark,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildPriceInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          '₹${product.price.toStringAsFixed(0)}',
          style: AppFonts.body2.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 6.w),
        if (product.mrp.isNotEmpty)
          Flexible(
            child: Text(
              'MRP ${product.mrp}',
              overflow: TextOverflow.ellipsis,
              style: AppFonts.body2.copyWith(
                decoration: TextDecoration.lineThrough,
                color: AppColors.textHint,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildRecipeLink() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF0FBF3), // Light green background
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            product.recipeLink!,
            style: AppFonts.body2.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 12.sp, color: AppColors.primary),
        ],
      ),
    );
  }
}
