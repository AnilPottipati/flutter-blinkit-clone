import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting

import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/controller/cart_controller.dart';
import '../../data/model/order_item_model.dart';
import '../../data/model/order_model.dart';
import '../../data/model/product_model.dart';
import '../components/common/custom_add_to_cart_button.dart';
import '../components/common/shimmer_box.dart';

class OrdersScreen extends StatelessWidget {
  static const String routeName = '/orders';

  const OrdersScreen({super.key});

  // Helper to get CartController instance
  CartController get cartController => Get.find<CartController>();

  // Dummy data for past orders
  List<Order> get _dummyPastOrders {
    // Define some dummy products
    final product1 = Product(
      id: 'p1',
      name: 'Fresh Apples',
      price: 2.50,
      imageUrl: 'assets/images/products/apple.png',
      mrp: '₹3.00',
      discount: '16% OFF',
      tag: 'Fresh',
    );
    final product2 = Product(
      id: 'p2',
      name: 'Organic Bananas',
      price: 1.80,
      imageUrl: 'assets/images/products/banana.png',
      mrp: '₹2.00',
      discount: '10% OFF',
      tag: 'Organic',
    );
    final product3 = Product(
      id: 'p3',
      name: 'Whole Milk (1L)',
      price: 1.20,
      imageUrl: 'assets/images/products/milk.png',
      mrp: '₹1.50',
      discount: '20% OFF',
      tag: 'Dairy',
    );
    final product4 = Product(
      id: 'p4',
      name: 'Brown Bread',
      price: 2.00,
      imageUrl: 'assets/images/products/bread.png',
      mrp: '₹2.20',
      discount: '9% OFF',
      tag: 'Bakery',
    );

    return [
      Order(
        id: 'order101',
        items: [
          OrderItem(product: product1, quantity: 2, priceAtPurchase: 2.40),
          OrderItem(product: product2, quantity: 6, priceAtPurchase: 1.75),
        ],
        orderDate: DateTime.now().subtract(const Duration(days: 5)),
        totalAmount: (2 * 2.40) + (6 * 1.75),
        status: OrderStatus.delivered,
        shippingAddress: '123 Green St, Anytown',
      ),
      Order(
        id: 'order102',
        items: [
          OrderItem(product: product3, quantity: 1, priceAtPurchase: 1.20),
          OrderItem(product: product4, quantity: 1, priceAtPurchase: 2.00),
          OrderItem(product: product1, quantity: 3, priceAtPurchase: 2.50),
        ],
        orderDate: DateTime.now().subtract(const Duration(days: 12)),
        totalAmount: 1.20 + 2.00 + (3 * 2.50),
        status: OrderStatus.delivered,
        shippingAddress: '456 Oak Ave, Anytown',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final RxBool isLoading = true.obs;
    final pastOrders = _dummyPastOrders;

    // Simulate loading for shimmer effect
    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);

    return Obx(() {
      if (isLoading.value) {
        // Show shimmer placeholders while loading
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: ShimmerBox(width: 120.w, height: 28.h, borderRadius: BorderRadius.circular(6)),
            backgroundColor: AppColors.scaffoldBackground,
            elevation: 1,
            iconTheme: IconThemeData(color: AppColors.textDark),
          ),
          body: ListView.builder(
            padding: EdgeInsets.all(12.w),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(bottom: 16.h),
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ShimmerBox(width: 120.w, height: 18.h, borderRadius: BorderRadius.circular(6)),
                          ShimmerBox(width: 80.w, height: 16.h, borderRadius: BorderRadius.circular(6)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ShimmerBox(width: double.infinity, height: 18.h, borderRadius: BorderRadius.circular(6)),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          ShimmerBox(width: 60.w, height: 16.h, borderRadius: BorderRadius.circular(6)),
                          SizedBox(width: 10.w),
                          ShimmerBox(width: 60.w, height: 16.h, borderRadius: BorderRadius.circular(6)),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: List.generate(3, (i) => Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: ShimmerBox(width: 48.w, height: 48.w, borderRadius: BorderRadius.circular(8)),
                        )),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(
            'My Past Orders',
            style: AppFonts.title2.copyWith(color: AppColors.textDark),
          ),
          backgroundColor: AppColors.scaffoldBackground,
          elevation: 1,
          iconTheme: IconThemeData(color: AppColors.textDark),
        ),
        body: pastOrders.isEmpty
            ? _buildEmptyOrdersView(context)
            : ListView.builder(
                padding: EdgeInsets.all(12.w),
                itemCount: pastOrders.length,
                itemBuilder: (context, index) {
                  final order = pastOrders[index];
                  return _buildOrderCard(context, order);
                },
              ),
      );
    });
  }

  Widget _buildEmptyOrdersView(BuildContext context) {
    // You can reuse your ReorderPromptWidget here or create a similar message
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 80.sp,
              color: AppColors.mediumGrey,
            ),
            SizedBox(height: 16.h),
            Text(
              'No past orders yet',
              style: AppFonts.title2.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Items you order will show up here so you can buy them again easily.',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(BuildContext context, Order order) {
    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order ID: ${order.id}',
                  style: AppFonts.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textMedium,
                  ),
                ),
                Text(
                  DateFormat(
                    'dd MMM yyyy',
                  ).format(order.orderDate), // e.g., 01 Jan 2024
                  style: AppFonts.bodySmall.copyWith(color: AppColors.textHint),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              'Total: \$${order.totalAmount.toStringAsFixed(2)}',
              style: AppFonts.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            Text(
              'Status: ${order.status.toString().split('.').last.capitalizeFirst}', // e.g., Delivered
              style: AppFonts.bodySmall.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            Divider(height: 20.h, thickness: 1, color: AppColors.divider),
            Text(
              'Items:',
              style: AppFonts.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textDark,
              ),
            ),
            SizedBox(height: 8.h),
            ...order.items
                .map((item) => _buildOrderItemTile(context, item))
                ,
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItemTile(BuildContext context, OrderItem item) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          // Placeholder for product image
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8.r),
              image:
                  item.product.imageUrl != null &&
                          item.product.imageUrl!.isNotEmpty
                      ? DecorationImage(
                        image: AssetImage(
                          item.product.imageUrl!,
                        ), // Ensure asset exists
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          // Handle image load error if needed
                        },
                      )
                      : null,
            ),
            child:
                item.product.imageUrl == null || item.product.imageUrl!.isEmpty
                    ? Icon(
                      Icons.image_not_supported_outlined,
                      color: AppColors.mediumGrey,
                      size: 24.sp,
                    )
                    : null,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.name,
                  style: AppFonts.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  // Note: Displaying original order quantity here, not cart quantity
                  'Original Qty: ${item.quantity} • Price: \$${item.priceAtPurchase.toStringAsFixed(2)}',
                  style: AppFonts.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          CustomAddToCartButton(product: item.product),
        ],
      ),
    );
  }
}
