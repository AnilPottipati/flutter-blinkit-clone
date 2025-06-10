import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinkit_clone/routes/route.dart';
import 'package:blinkit_clone/core/colors.dart';

class OtpController extends GetxController {
  final String phoneNumber;
  OtpController({required this.phoneNumber});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController pinController = TextEditingController();
  final RxString currentOtp = ''.obs;

  static const int initialTimerDuration = 30;
  final RxInt timerDuration = initialTimerDuration.obs;
  final RxBool isTimerActive = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel(); // Cancel the timer first
    pinController.dispose(); // Then dispose the TextEditingController
    super.onClose();
  }

  void startTimer() {
    isTimerActive(true);
    timerDuration(initialTimerDuration);
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerDuration.value > 0) {
        timerDuration.value--;
      } else {
        isTimerActive(false);
        timer.cancel();
      }
    });
  }

  void onOtpChanged(String value) {
    currentOtp.value = value;
  }

  void onOtpCompleted(String value) {
    currentOtp.value = value;
    // Optionally, automatically submit if desired
    // verifyOtp(); 
  }

  void verifyOtp() {
    if (currentOtp.value.length == 6) {
      if (formKey.currentState!.validate()) {
        // TODO: Implement actual OTP verification logic with a backend service
        // For now, simulate success and navigate
        Get.offAllNamed(Routes.home);
        Get.snackbar(
          'Success',
          'OTP Verified Successfully for $phoneNumber',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.success,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter the complete 6-digit OTP.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.error,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  void resendOtp() {
    // TODO: Implement actual resend OTP logic with a backend service
    // For now, simulate resend and restart timer
    startTimer();
    pinController.clear();
    currentOtp('');
    Get.snackbar(
      'OTP Resent',
      'A new OTP has been sent to $phoneNumber (Simulated).',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.info,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 8,
    );
  }
}
