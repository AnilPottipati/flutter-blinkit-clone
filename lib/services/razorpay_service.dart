import 'package:flutter/material.dart'; // For Get.snackbar styling
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../data/model/payment_model.dart';
import '../data/controller/cart_controller.dart'; // Adjusted path for CartController
import '../routes/route.dart';
import '../data/model/order_model.dart';
import '../data/model/order_item_model.dart';

class PaymentController extends GetxController {
  late Razorpay _razorpay;
  final paymentData = PaymentModel(
    keyId: 'rzp_test_XzfD7JSW9dmci4', // Your Test Key ID
    amount: '0', // This will be updated before checkout
    name: 'Blinkit Clone', // Your Store Name
    description: 'Order Payment', // Default description
    prefillEmail: 'customer@example.com', // Placeholder, update with actual user data
    prefillContact: '9876543210', // Placeholder, update with actual user data
  ).obs;

  final isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    debugPrint('[PaymentController] Initialized and listeners attached.');
  }

  @override
  void onClose() {
    _razorpay.clear(); // Clear listeners
    debugPrint('[PaymentController] Disposed and listeners cleared.');
    super.onClose();
  }

  void openCheckout() {
    if (paymentData.value.amount == '0' || double.tryParse(paymentData.value.amount) == 0) {
        Get.snackbar('Error', 'Payment amount cannot be zero.');
        return;
    }
    var options = paymentData.value.toJson();
    debugPrint("[PaymentController] Checkout Options: $options");
    isProcessing.value = true;

    try {
      _razorpay.open(options);
    } catch (e) {
      isProcessing.value = false;
      debugPrint('[PaymentController] Error opening Razorpay checkout: $e');
      Get.snackbar('Error', 'Could not launch Razorpay: $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    isProcessing.value = false;
    debugPrint('[PaymentController] Payment Success: ${response.paymentId}');

    final cartController = Get.find<CartController>();

    // Create OrderItems from CartItems
    List<OrderItem> orderItems = cartController.cartItems.map((cartItem) {
      return OrderItem(
        product: cartItem.product,
        quantity: cartItem.quantity.value,
        priceAtPurchase: cartItem.product.price, // Assuming current price is price at purchase
      );
    }).toList();

    // Create the Order object
    final newOrder = Order(
      id: 'order_${DateTime.now().millisecondsSinceEpoch}', // Simple unique ID
      items: orderItems,
      orderDate: DateTime.now(),
      totalAmount: cartController.grandTotal.value,
      status: OrderStatus.processing, // Or OrderStatus.placed
      // shippingAddress: '', // TODO: Get shipping address if available
    );

    Get.snackbar(
        'Success',
        'Payment ID: ${response.paymentId}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white
    );

    // Navigate to the payment success screen with the order details
    Get.offAllNamed(Routes.paymentSuccess, arguments: newOrder);

    // Clear the cart after processing the order and navigating
    cartController.clearCart(); 
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    isProcessing.value = false;
    debugPrint('[PaymentController] Payment Error: ${response.code} - ${response.message}');
    Get.snackbar(
        'Error',
        'Payment failed: ${response.message} (Code: ${response.code})',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // This event is triggered when a user selects an external wallet (like UPI apps)
    // but before the payment is completed in that app.
    // You might not need to do much here other than logging or specific UI updates.
    debugPrint('[PaymentController] External Wallet Selected: ${response.walletName}');
    Get.snackbar(
        'Wallet Selected',
        'Processing with ${response.walletName}...',
        snackPosition: SnackPosition.BOTTOM
    );
  }
}
