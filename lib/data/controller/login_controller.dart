import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinkit_clone/view/screens/auth/otp_screen.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    }
    if (value.startsWith('0')) {
      return 'Mobile number cannot start with 0';
    }
    if (value.length != 10) {
      return 'Mobile number must be 10 digits';
    }
    return null;
  }

  void submitPhoneNumber() {
    if (formKey.currentState!.validate()) {
      Get.toNamed(
        OTPScreen.routeName,
        arguments: phoneController.text,
      );
    }
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }
}
