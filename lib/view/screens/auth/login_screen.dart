import 'package:flutter/material.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';
import 'package:get/get.dart';
import 'package:blinkit_clone/view/components/common/custom_text_form_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:blinkit_clone/data/controller/login_controller.dart'; // Import the controller

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Lottie.asset(
                'assets/images/animations/login2.json',
                height: screenHeight * 0.4, // Adjust height as needed
                fit: BoxFit.contain,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      'Blinkit',
                      textAlign: TextAlign.center,
                      style: AppFonts.heading2.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.h), // Spacing after logo group
                    Text(
                      'India\'s last minute app',
                      textAlign: TextAlign.center,
                      style: AppFonts.heading1.copyWith(
                        color: AppColors.textDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Log In or Sign Up',
                      textAlign: TextAlign.center,
                      style: AppFonts.bodyLarge.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: controller.formKey, // Use controller's formKey
                      child: CustomTextFormField(
                        controller: controller.phoneController, // Use controller's phoneController
                        keyboardType: TextInputType.phone,
                        maxLength: 10,
                        validator: controller.validatePhoneNumber, // Use controller's validator
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              12,
                              14,
                              8,
                              14,
                            ),
                            child: Text(
                              '+91',
                              style: AppFonts.bodyLarge.copyWith(
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          hintText: 'Enter mobile number',
                          hintStyle: AppFonts.bodyMedium.copyWith(
                            color: AppColors.textHint,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: AppColors.border,
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: AppColors.border,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: AppColors.error,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: AppColors.error,
                              width: 1.5,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                          ),
                          counterText: '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[700], // Dark grey button
                        padding: const EdgeInsets.symmetric(vertical: 14.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      onPressed: controller.submitPhoneNumber, // Use controller's submit method
                      child: Text(
                        'Continue',
                        style: AppFonts.bodyLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 20.0,
                  left: 24.0,
                  right: 24.0,
                ),
                child: Text(
                  'By continuing, you agree to our Terms of service & Privacy policy',
                  textAlign: TextAlign.center,
                  style: AppFonts.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
