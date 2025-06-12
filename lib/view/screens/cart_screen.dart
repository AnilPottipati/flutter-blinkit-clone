import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart'; // No longer directly used here

import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/controller/cart_controller.dart';
import '../../data/model/cart_item_model.dart';
import '../../services/razorpay_service.dart'; // Now imports PaymentController
import '../../data/controller/delivery_address_controller.dart';
import '../components/location/location_selection_sheet.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const String routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cartController = Get.find<CartController>();
  // Use PaymentController from GetX
  final PaymentController _paymentController = Get.put(PaymentController());
  final DeliveryAddressController _addressController = Get.put(DeliveryAddressController(), permanent: true);

  @override
  void initState() {
    super.initState();
    // Initialization of PaymentController and its listeners is handled by GetX (onInit)
  }

  // Payment event handlers are now within PaymentController

  void _initiateCheckout() {
    debugPrint('[CartScreen] _initiateCheckout called.');
    if (_cartController.cartItems.isEmpty) {
      debugPrint('[CartScreen] Cart is empty, showing snackbar.');
      Get.snackbar('Empty Cart', 'Please add items to your cart before checking out.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    if (!_addressController.isAddressSelected) {
      Get.snackbar('Select Address', 'Please choose a delivery address before checkout.', snackPosition: SnackPosition.BOTTOM);
      // open selection sheet
      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (_) => const LocationSelectionSheet(),
      );
      return;
    }

    // Example prefill data - replace with actual user data if available
    String? userName = "Test User"; // Replace with actual user data from your app's state/auth
    String? userEmail = "test.user@example.com";
    String? userContact = "9876543210";

    debugPrint('[CartScreen] Proceeding to open Razorpay checkout.');
    debugPrint('[CartScreen] Amount: ${_cartController.grandTotal.value}, User: $userName, Email: $userEmail, Contact: $userContact');
    // Update paymentData in PaymentController
    _paymentController.paymentData.update((val) {
      if (val != null) {
        val.amount = _cartController.grandTotal.value.toString();
        val.description = 'Order from Blinkit Clone'; // Or generate dynamically
        val.prefillEmail = userEmail; // userEmail is non-null here due to initialization
        val.prefillContact = userContact; // userContact is non-null here due to initialization
        // val.name can remain as store name or be updated if needed
        // val.orderId = 'YOUR_SERVER_GENERATED_ORDER_ID'; // If you have one
      }
    });

    _paymentController.openCheckout();
  }

  @override
  void dispose() {
    // PaymentController's dispose (onClose) is handled by GetX
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: AppFonts.title2.copyWith(color: AppColors.textDark),
        ),
        backgroundColor: AppColors.scaffoldBackground,
        elevation: 1,
        iconTheme: IconThemeData(color: AppColors.textDark),
      ),
      body: Obx(() {
        if (_cartController.cartItems.isEmpty) {
          return _buildEmptyCartView(context);
        }
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                itemCount: _cartController.cartItems.length,
                itemBuilder: (context, index) {
                  final cartItem = _cartController.cartItems[index];
                  return _buildCartItemTile(context, cartItem);
                },
              ),
            ),
            _buildCartSummary(context),
          ],
        );
      }),
    );
  }

  Widget _buildEmptyCartView(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 80.sp,
              color: AppColors.mediumGrey,
            ),
            SizedBox(height: 16.h),
            Text(
              'Your cart is empty',
              style: AppFonts.title2.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.h),
            Text(
              'Looks like you haven\'t added anything to your cart yet.',
              style: AppFonts.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: () {
                Get.back(); // Go back to the previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                textStyle: AppFonts.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: Text(
                'Start Shopping',
                style: AppFonts.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItemTile(BuildContext context, CartItem cartItem) {
    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      elevation: 1.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Row(
          children: [
            // Product Image Placeholder
            Container(
              width: 70.w,
              height: 70.h,
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(8.r),
                image:
                    cartItem.product.imageUrl != null &&
                            cartItem.product.imageUrl!.isNotEmpty
                        ? DecorationImage(
                          image: AssetImage(
                            cartItem.product.imageUrl!,
                          ), // Ensure asset exists
                          fit: BoxFit.cover,
                          onError: (exception, stackTrace) {
                            /* Handle error */
                          },
                        )
                        : null,
              ),
              child:
                  cartItem.product.imageUrl == null ||
                          cartItem.product.imageUrl!.isEmpty
                      ? Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.mediumGrey,
                        size: 30.sp,
                      )
                      : null,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cartItem.product.name,
                    style: AppFonts.body1Strong,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    '₹${cartItem.product.price.toStringAsFixed(2)}',
                    style: AppFonts.bodyMedium.copyWith(
                      color: AppColors.textMedium,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.w),
            // Quantity Controls
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.remove_circle_outline,
                        color: AppColors.primary,
                        size: 22.sp,
                      ),
                      onPressed:
                          () => _cartController.decrementQuantity(cartItem),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                    Obx(
                      () => Text(
                        '${cartItem.quantity.value}',
                        style: AppFonts.bodyLarge.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.add_circle_outline,
                        color: AppColors.primary,
                        size: 22.sp,
                      ),
                      onPressed:
                          () => _cartController.incrementQuantity(cartItem),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '₹${cartItem.totalPrice.toStringAsFixed(2)}',
                  style: AppFonts.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 4.h),
                IconButton(
                  icon: Icon(
                    Icons.delete_outline,
                    color: AppColors.error,
                    size: 24.sp,
                  ),
                  onPressed: () => _cartController.removeItem(cartItem),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(51),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Address display section
          Obx(() {
            if (_addressController.isAddressSelected) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.location_on_outlined, color: AppColors.textDark, size: 20.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Deliver to", style: AppFonts.caption.copyWith(color: AppColors.textHint)),
                        Text(
                          _addressController.selectedAddress.value,
                          style: AppFonts.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.bottomSheet(
                        const LocationSelectionSheet(),
                        isScrollControlled: true,
                      );
                    },
                    child: Text(
                      'Change',
                      style: AppFonts.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            } else {
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (_) => const LocationSelectionSheet(),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select a delivery address',
                        style: AppFonts.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.textHint),
                    ],
                  ),
                ),
              );
            }
          }),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtotal',
                style: AppFonts.bodyLarge.copyWith(color: AppColors.textMedium),
              ),
              Obx(() => Text(
                    '₹${_cartController.subtotalPrice.value.toStringAsFixed(2)}',
                    style: AppFonts.bodyLarge.copyWith(color: AppColors.textDark),
                  )),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Delivery Fee',
                style: AppFonts.bodyLarge.copyWith(color: AppColors.textMedium),
              ),
              Obx(() => Text(
                    '₹${_cartController.deliveryFee.value.toStringAsFixed(2)}',
                    style: AppFonts.bodyLarge.copyWith(color: AppColors.textDark),
                  )),
            ],
          ),
                    SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'GST (5%)',
                style: AppFonts.bodyLarge.copyWith(color: AppColors.textMedium),
              ),
              Obx(() => Text(
                    '₹${_cartController.gst.value.toStringAsFixed(2)}',
                    style: AppFonts.bodyLarge.copyWith(color: AppColors.textDark),
                  )),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'SGST (5%)',
                style: AppFonts.bodyLarge.copyWith(color: AppColors.textMedium),
              ),
              Obx(() => Text(
                    '₹${_cartController.sgst.value.toStringAsFixed(2)}',
                    style: AppFonts.bodyLarge.copyWith(color: AppColors.textDark),
                  )),
            ],
          ),
          Divider(height: 24.h, thickness: 1.h, color: AppColors.lightGrey),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Grand Total Amount',
                style: AppFonts.title3.copyWith(fontWeight: FontWeight.bold),
              ),
              Obx(() => Text(
                    '₹${_cartController.grandTotal.value.toStringAsFixed(2)}',
                    style: AppFonts.title3.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  )),
            ],
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: _initiateCheckout, // Updated onPressed to call our new method
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              textStyle: AppFonts.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              'Proceed to Checkout',
              style: AppFonts.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
