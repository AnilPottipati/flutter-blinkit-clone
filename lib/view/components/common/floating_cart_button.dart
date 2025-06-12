import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/colors.dart';
import '../../../data/controller/cart_controller.dart';
import '../../screens/cart_screen.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();
    return Obx(() {
      final int cartCount = cartController.totalCartQuantity;
      return Stack(
        clipBehavior: Clip.none,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.routeName);
            },
            backgroundColor: AppColors.primary,
            child: Icon(
              Icons.shopping_cart_outlined,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          if (cartCount > 0)
            Positioned(
              right: -2.w,
              top: -2.h,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).colorScheme.onPrimary, width: 2),
                ),
                constraints: BoxConstraints(
                  minWidth: 20.w,
                  minHeight: 20.w,
                ),
                child: Center(
                  child: Text(
                    cartCount > 99 ? '99+' : '$cartCount',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}

