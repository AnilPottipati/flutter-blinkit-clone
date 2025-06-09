import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/colors.dart';
import '../../../core/fonts.dart';
import '../../../data/controller/cart_controller.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/cart_item_model.dart'; // Required for CartItem type

class CustomAddToCartButton extends StatelessWidget {
  final Product product;
  final CartController _cartController = Get.find<CartController>();

  CustomAddToCartButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final quantityInCart = _cartController.getProductQuantityInCart(product.id);

      if (quantityInCart == 0) {
        return ElevatedButton(
          onPressed: () {
            _cartController.addItem(product);
            Get.snackbar(
              'Added to Cart',
              '${product.name} added to your cart.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.success.withAlpha(230),
              colorText: Colors.white,
              margin: EdgeInsets.all(12.w),
              borderRadius: 8.r,
              duration: const Duration(seconds: 2),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            textStyle: AppFonts.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: Text(
            'Add',
            style: AppFonts.bodySmall.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      } else {
        // Item is in cart, show quantity controller
        final CartItem? cartItem = _cartController.getCartItemByProductId(product.id);

        // This check is crucial because getCartItemByProductId can return null
        // even if quantityInCart > 0 if the item was just removed in a rapid sequence of events.
        // Or if there's a slight delay in UI update vs controller state.
        if (cartItem == null) {
          // Fallback: If cartItem is somehow null, show 'Add' button to prevent error.
          // This state should ideally not be reached if quantityInCart > 0.
          return ElevatedButton(
            onPressed: () => _cartController.addItem(product),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
            child: Text('Add', style: AppFonts.bodySmall.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
          );
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.remove_circle_outline, color: AppColors.primary, size: 22.sp),
              onPressed: () => _cartController.decrementQuantity(cartItem),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                '${cartItem.quantity.value}', // Accessing .value as quantity is RxInt
                style: AppFonts.bodyLarge.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: AppColors.primary, size: 22.sp),
              onPressed: () => _cartController.incrementQuantity(cartItem),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        );
      }
    });
  }
}
