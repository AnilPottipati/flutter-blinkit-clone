import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/product_item.dart'; // Assuming ProductItem has all necessary fields

class BestsellerItemCardWidget extends StatelessWidget {
  final ProductItem product;
  final VoidCallback? onAddTap;
  final VoidCallback? onViewRecipesTap;

  const BestsellerItemCardWidget({
    super.key,
    required this.product,
    this.onAddTap,
    this.onViewRecipesTap,
  });

  @override
  Widget build(BuildContext context) {
    // Define styles based on the reference image
    final productNameStyle = AppFonts.bodyMedium.copyWith(color: AppColors.textDark, fontWeight: FontWeight.w500, height: 1.25);
    final unitStyle = AppFonts.caption.copyWith(color: AppColors.textMedium, fontSize: 12.sp);
    // final deliveryTimeStyle = AppFonts.caption.copyWith(color: AppColors.textDark, fontSize: 11.sp, fontWeight: FontWeight.w500); // Unused
    final discountStyle = AppFonts.caption.copyWith(color: AppColors.success, fontSize: 11.sp, fontWeight: FontWeight.bold);
    final priceStyle = AppFonts.bodyLarge.copyWith(color: AppColors.textDark, fontWeight: FontWeight.bold, fontSize: 15.sp);
    final mrpStyle = AppFonts.caption.copyWith(color: AppColors.textHint, decoration: TextDecoration.lineThrough, fontSize: 11.sp);
    final recipeLinkStyle = AppFonts.caption.copyWith(color: AppColors.primary, fontSize: 11.sp, fontWeight: FontWeight.w500);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.lightGrey.withAlpha((255 * 0.4).round()), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((255 * 0.04).round()),
            blurRadius: 5.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Image with ADD button overlay ---
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
                child: Image.asset(
                  product.imageUrl, // Ensure this path is correct
                  height: 110.h, // Adjusted for visual balance
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 110.h,
                      color: AppColors.lightGrey.withAlpha((255 * 0.3).round()),
                      child: Center(child: Icon(Icons.broken_image_outlined, color: AppColors.mediumGrey, size: 30.sp)),
                    );
                  },
                ),
              ),
              Positioned(
                bottom: 8.h,
                right: 8.w,
                child: SizedBox(
                  height: 30.h,
                  width: 65.w, 
                  child: ElevatedButton(
                    onPressed: onAddTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cardBackground,
                      foregroundColor: AppColors.primary, // Text color
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                        side: BorderSide(color: AppColors.primary.withAlpha((255 * 0.7).round()), width: 1.2.w),
                      ),
                      elevation: 1.5,
                      shadowColor: AppColors.primary.withAlpha((255 * 0.2).round()),
                    ),
                    child: Text('ADD', style: AppFonts.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 12.sp)),
                  ),
                ),
              ),
            ],
          ),
          // --- Product Details Below Image ---
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h), // Reduced padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Added to shrink vertically
              children: [
                if (product.unit.isNotEmpty) ...[
                  Text(product.unit, style: unitStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                  SizedBox(height: 1.h), // Reduced
                ],
                Text(product.name, style: productNameStyle, maxLines: 2, overflow: TextOverflow.ellipsis),
                SizedBox(height: 2.h), // Reduced
                
                // Delivery Time (assuming product.deliveryTime is like '10 MINS') - REMOVED
                // // If it's just a duration, you might need to format it with an icon
                // if (product.deliveryTime.isNotEmpty) ...[
                //   Row(
                //     children: [
                //       Icon(Icons.access_time_rounded, color: AppColors.textDark, size: 12.sp),
                //       SizedBox(width: 3.w), // Slightly reduced
                //       Flexible(child: Text(product.deliveryTime, style: deliveryTimeStyle, maxLines: 1, overflow: TextOverflow.ellipsis)), // Made Flexible
                //     ],
                //   ),
                //   SizedBox(height: 2.h), // Reduced
                // ],

                // Discount Tag (e.g., '20% OFF')
                if (product.discountTag != null && product.discountTag!.isNotEmpty) ...[
                  Text(product.discountTag!, style: discountStyle, maxLines: 1, overflow: TextOverflow.ellipsis), // Added maxLines & overflow
                  SizedBox(height: 2.h), // Reduced
                ],

                // Price Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text('₹${product.discountedPrice.toStringAsFixed(0)}', style: priceStyle),
                    if (product.originalPrice != null && product.originalPrice! > product.discountedPrice) ...[
                      SizedBox(width: 6.w),
                      Text('₹${product.originalPrice!.toStringAsFixed(0)}', style: mrpStyle),
                    ],
                  ],
                ),
                SizedBox(height: 3.h), // Reduced

                // Recipe Link
                if (product.recipeCount != null && product.recipeCount! > 0) ...[
                  Flexible( // Added Flexible around InkWell
                    child: InkWell(
                      onTap: onViewRecipesTap,
                      child: Row(
                        children: [
                          Flexible( // Changed Expanded to Flexible for Text
                            child: Text(
                              'See ${product.recipeCount} recipes',
                              style: recipeLinkStyle,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          SizedBox(width: 3.w),
                          Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 10.sp),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  // Add a SizedBox to maintain height consistency if no recipe link
                  SizedBox(height: 10.sp + 3.h + 1.h), // Approx height of recipe link row
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
