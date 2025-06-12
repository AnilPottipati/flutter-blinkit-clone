import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/controller/cart_controller.dart';
import '../../../core/colors.dart';
import '../../../core/fonts.dart';
import '../../../data/model/cart_item_model.dart';
import '../../../data/model/product_model.dart';

class CustomAddButton extends StatefulWidget {
  final Product product;

  const CustomAddButton({super.key, required this.product});

  @override
  State<CustomAddButton> createState() => _CustomAddButtonState();
}

class _CustomAddButtonState extends State<CustomAddButton> with SingleTickerProviderStateMixin {
  final CartController _cartController = Get.find<CartController>();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      reverseDuration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _animationController.reverse();
  }
    void _onTapCancel() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final CartItem? cartItem = _cartController.getCartItemByProductId(widget.product.id);
      final int quantityInCart = cartItem?.quantity.value ?? 0;

      return ScaleTransition(
        scale: _scaleAnimation,
        child: quantityInCart == 0
            ? _buildAddButton()
            : _buildQuantitySelector(cartItem!),
      );
    });
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      onTap: () => _cartController.addItem(widget.product),
      child: Container(
        width: 85.w, // Slightly smaller
        height: 34.h, // Slightly smaller
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r), // More rounded
          border: Border.all(color: AppColors.primary, width: 1.2), // Thinner border
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ADD',
              style: AppFonts.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w900, letterSpacing: 0.5),
            ),
            if (widget.product.variantInfo != null && widget.product.variantInfo!.isNotEmpty)
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                  widget.product.variantInfo!,
                  style: AppFonts.caption.copyWith(fontSize: 9.sp, color: AppColors.textHint, fontWeight: FontWeight.w600),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuantitySelector(CartItem cartItem) {
    return Container(
      width: 85.w,
      height: 34.h,
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Better spacing
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSelectorButton(
            icon: Icons.remove,
            onPressed: () => _cartController.decrementQuantity(cartItem),
          ),
          Text(
            '${cartItem.quantity.value}',
            style: AppFonts.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          _buildSelectorButton(
            icon: Icons.add,
            onPressed: () => _cartController.incrementQuantity(cartItem),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectorButton({required IconData icon, required VoidCallback onPressed}) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: onPressed,
      child: Container(
        color: Colors.transparent, // For hit testing
        padding: EdgeInsets.all(4.w),
        child: Icon(icon, color: Colors.white, size: 18.sp),
      ),
    );
  }
}
