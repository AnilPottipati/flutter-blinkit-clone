import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/order_model.dart';
import '../../data/model/order_item_model.dart';
import '../../routes/route.dart'; // For Routes.home

class MyOrdersScreen extends StatelessWidget {
  static const String routeName = '/my-order-details';

  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Order? order = Get.arguments as Order?;

    if (order == null) {
      // Handle case where order is not passed, though ideally this shouldn't happen
      return Scaffold(
        appBar: AppBar(title: Text('Error', style: AppFonts.title2)),
        body: Center(
          child: Text('No order details found.', style: AppFonts.bodyLarge),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Order Details', style: AppFonts.title2.copyWith(color: AppColors.textDark)),
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 1,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderSummary(order),
            SizedBox(height: 20.h),
            Text('Items Ordered:', style: AppFonts.title2.copyWith(fontSize: 18.sp)),
            SizedBox(height: 10.h),
            _buildOrderItemsList(order.items),
            SizedBox(height: 30.h),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
                  textStyle: AppFonts.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                ),
                onPressed: () {
                  Get.offAllNamed(Routes.home); // Navigate to home and clear stack
                },
                child: Text('Continue Shopping', style: AppFonts.bodyLarge.copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(Order order) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _summaryRow('Order ID:', order.id),
            _summaryRow('Order Date:', DateFormat('dd MMM yyyy, hh:mm a').format(order.orderDate)),
            _summaryRow('Status:', order.status.toString().split('.').last.capitalizeFirst ?? order.status.toString()),
            if (order.shippingAddress != null && order.shippingAddress!.isNotEmpty)
              _summaryRow('Shipping Address:', order.shippingAddress!),
            Divider(height: 20.h, thickness: 1, color: AppColors.divider),
            _summaryRow('Total Amount:', '\u20B9${order.totalAmount.toStringAsFixed(2)}', isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppFonts.bodyMedium.copyWith(color: AppColors.textSecondary)),
          Text(
            value,
            style: isTotal
                ? AppFonts.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: AppColors.primary)
                : AppFonts.bodyMedium.copyWith(color: AppColors.textDark, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItemsList(List<OrderItem> items) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (context, index) => Divider(height: 16.h, color: AppColors.divider.withAlpha(128)),
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                item.product.imageUrl != null && item.product.imageUrl!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: CachedNetworkImage(
                          imageUrl: item.product.imageUrl!,
                          width: 60.w,
                          height: 60.w,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 60.w, height: 60.w, 
                            color: AppColors.lightGrey,
                            child: Icon(Icons.image, color: AppColors.mediumGrey, size: 30.sp),
                          ),
                          errorWidget: (context, url, error) => Container(
                            width: 60.w, height: 60.w, 
                            color: AppColors.lightGrey,
                            child: Icon(Icons.broken_image, color: AppColors.mediumGrey, size: 30.sp),
                          ),
                        ),
                      )
                    : Container(
                        width: 60.w, height: 60.w, 
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(Icons.fastfood, color: AppColors.mediumGrey, size: 30.sp),
                      ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.product.name, style: AppFonts.body1Strong, maxLines: 2, overflow: TextOverflow.ellipsis),
                      SizedBox(height: 4.h),
                      Text('Quantity: ${item.quantity}', style: AppFonts.bodySmall.copyWith(color: AppColors.textMedium)),
                      Text('Price: \u20B9${item.priceAtPurchase.toStringAsFixed(2)}', style: AppFonts.bodySmall.copyWith(color: AppColors.textMedium)),
                    ],
                  ),
                ),
                SizedBox(width: 8.w),
                Text('\u20B9${item.totalPrice.toStringAsFixed(2)}', style: AppFonts.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.textDark)),
              ],
            ),
          ),
        );
      },
    );
  }
}
