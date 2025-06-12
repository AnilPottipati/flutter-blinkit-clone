import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import 'package:blinkit_clone/routes/route.dart';
import 'package:blinkit_clone/data/model/order_model.dart';
import 'package:blinkit_clone/data/controller/delivery_address_controller.dart';

class PaymentSuccessScreen extends StatefulWidget {
  static const String routeName = '/payment-success';

  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen> {
  Order? _order;
  @override
  void initState() {
    super.initState();
    // It's safer to get arguments once, e.g., in initState or didChangeDependencies
    // However, Get.arguments can be accessed directly too. For simplicity here:
    _order = Get.arguments as Order?;
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      // Navigate to MapScreen for destination selection & live tracking
      final addrCtrl = Get.find<DeliveryAddressController>();
      Get.offNamed(Routes.map, arguments: {
        'order': _order,
        'destination': addrCtrl.selectedLatLng.value,
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/animations/payment.json',
              width: 300.w, // Adjusted size for Lottie animation
              height: 300.h,
              repeat: false, // Play animation once
            ),
            SizedBox(height: 20.h),
            Text(
              'Payment Successful!',
              style: AppFonts.heading2.copyWith(color: AppColors.background),
            ),
            SizedBox(height: 10.h),
            Text(
              'Your order has been placed.',
              style: AppFonts.bodyLarge.copyWith(
                color: AppColors.background.withAlpha(204),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
