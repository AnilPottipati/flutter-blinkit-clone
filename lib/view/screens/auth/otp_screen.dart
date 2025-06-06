import 'package:flutter/material.dart';
import 'package:blinkit_clone/core/colors.dart'; 
import 'package:blinkit_clone/core/fonts.dart';   
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../data/controller/otp_controller.dart';

class OTPScreen extends StatefulWidget {
  static const String routeName = '/otp';
  final String phoneNumber;

  const OTPScreen({super.key, required this.phoneNumber});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController(phoneNumber: widget.phoneNumber));

    return Scaffold(
      appBar: AppBar(
        title: Text('Enter OTP', style: AppFonts.heading2.copyWith(color: AppColors.textPrimary)),
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Enter the 6-digit OTP sent to\n+91 ${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: AppFonts.title2.copyWith(color: AppColors.textDark, height: 1.5),
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: controller.pinController,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8.0),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    activeFillColor: Colors.white,
                    inactiveFillColor: AppColors.lightGrey.withAlpha(77),
                    selectedFillColor: Colors.white,
                    activeColor: AppColors.primary,
                    inactiveColor: AppColors.mediumGrey,
                    selectedColor: AppColors.primary,
                    borderWidth: 1,
                  ),
                  textStyle: AppFonts.heading2.copyWith(color: AppColors.textDark),
                  cursorColor: AppColors.primary,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  keyboardType: TextInputType.number,
                  onCompleted: controller.onOtpCompleted,
                  onChanged: controller.onOtpChanged,
                  beforeTextPaste: (text) {
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen. 
                    //but you can show anything you want here, like your pop up saying wrong paste format or something 
                    return true;
                  },
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 14.0),
                  textStyle: AppFonts.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: controller.verifyOtp,
                child: Text('Verify OTP', style: AppFonts.bodyLarge.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 20),
              Obx(() => TextButton(
                onPressed: controller.isTimerActive.value ? null : controller.resendOtp,
                child: Text(
                  controller.isTimerActive.value 
                      ? 'Resend OTP in ${controller.timerDuration.value}s' 
                      : 'Resend OTP',
                  style: AppFonts.bodyMedium.copyWith(
                    color: controller.isTimerActive.value ? AppColors.textHint : AppColors.primary, 
                    fontWeight: FontWeight.bold
                  )
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Get.delete<OtpController>(); // Optional: if you want to explicitly delete controller when screen is disposed
    super.dispose();
  }
}
