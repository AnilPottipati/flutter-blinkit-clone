import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:blinkit_clone/core/colors.dart';
import 'package:blinkit_clone/core/fonts.dart';
import '../components/common/shimmer_box.dart';
import 'package:blinkit_clone/data/controller/profile_controller.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    

    final RxBool isLoading = false.obs;
    // Simulate loading for shimmer effect
    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);
    return Obx(() {
      if (isLoading.value) {
        // Show shimmer placeholders while loading
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: ShimmerBox(width: 120.w, height: 28.h, borderRadius: BorderRadius.circular(6)),
            backgroundColor: AppColors.background,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            children: [
              ShimmerBox(width: double.infinity, height: 80.h, borderRadius: BorderRadius.circular(12), margin: EdgeInsets.symmetric(horizontal: 16.w)),
              SizedBox(height: 20.h),
              ...List.generate(6, (i) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: ShimmerBox(width: double.infinity, height: 40.h, borderRadius: BorderRadius.circular(8)),
              )),
            ],
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            scrolledUnderElevation: 0,
            title: Text('Profile', style: AppFonts.heading2.copyWith(color: AppColors.textDark)),
            backgroundColor: AppColors.background,
          ),
          body: ListView(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            children: [
              _buildUserInfoSection(controller),
              SizedBox(height: 20.h),
              _buildQuickActionsSection(controller),
              SizedBox(height: 20.h),
              
              SizedBox(height: 15.h),
              _buildSectionHeader('YOUR INFORMATION'),
              _buildProfileListItem(controller, Icons.receipt_long_outlined, 'Your orders', () => controller.navigateToYourOrders()),
              _buildProfileListItem(controller, Icons.bookmark_border_outlined, 'Bookmarked recipes', () => controller.navigateToBookmarkedRecipes()),
              _buildProfileListItem(controller, Icons.menu_book_outlined, 'Address book', () => controller.navigateToAddressBook()),
              _buildProfileListItem(controller, Icons.description_outlined, 'GST details', () => controller.navigateToGstDetails()),
              _buildProfileListItem(controller, Icons.card_giftcard_outlined, 'E-Gift Cards', () => controller.navigateToEGiftCards()),
              SizedBox(height: 15.h),
              _buildSectionHeader('PAYMENTS AND COUPONS'),
              _buildProfileListItem(controller, Icons.account_balance_wallet_outlined, 'Wallet', () => controller.navigateToWallet()),
              _buildProfileListItem(controller, Icons.credit_card_outlined, 'Blinkit Money', () => controller.navigateToBlinkitMoney()),
              _buildProfileListItem(controller, Icons.settings_outlined, 'Payment settings', () => controller.navigateToPaymentSettings()),
              _buildProfileListItem(controller, Icons.military_tech_outlined, 'Your collected rewards', () => controller.navigateToCollectedRewards()),
              SizedBox(height: 15.h),
              _buildSectionHeader('OTHER INFORMATION'),
              _buildProfileListItem(controller, Icons.share_outlined, 'Share the app', () => controller.shareApp()),
              _buildProfileListItem(controller, Icons.info_outline, 'About us', () => controller.navigateToAboutUs()),
              _buildProfileListItem(controller, Icons.food_bank_outlined, 'Get Feeding India receipt', () => controller.getFeedingIndiaReceipt()),
              _buildProfileListItem(controller, Icons.privacy_tip_outlined, 'Account privacy', () => controller.navigateToAccountPrivacy()),
              _buildProfileListItem(controller, Icons.notifications_outlined, 'Notification preferences', () => controller.navigateToNotificationPreferences()),
              _buildProfileListItem(controller, Icons.logout_outlined, 'Log out', () => controller.logout(), showTrailingIcon: false, color: AppColors.error),
              SizedBox(height: 30.h),
              _buildFooter(controller),
              SizedBox(height: 20.h),
            ],
          ),
        );
      }
    });
  }

  Widget _buildUserInfoSection(ProfileController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() => Text(
            controller.userName.value,
            style: AppFonts.heading1.copyWith(fontSize: 28.sp, fontWeight: FontWeight.bold, color: AppColors.textDark),
          )),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.phone_outlined, color: AppColors.textMedium, size: 16.sp),
              SizedBox(width: 8.w),
              Obx(() => Text(
                controller.userPhoneNumber.value,
                style: AppFonts.bodyMedium.copyWith(color: AppColors.textMedium, fontSize: 14.sp),
              )),
              SizedBox(width: 16.w),
              Icon(Icons.calendar_today_outlined, color: AppColors.textMedium, size: 16.sp),
              SizedBox(width: 8.w),
              Obx(() => Text(
                controller.userDob.value,
                style: AppFonts.bodyMedium.copyWith(color: AppColors.textMedium, fontSize: 14.sp),
              )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection(ProfileController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildQuickActionCard(Icons.account_balance_wallet_outlined, 'Blinkit Money'),
          _buildQuickActionCard(Icons.support_agent_outlined, 'Support'),
          _buildQuickActionCard(Icons.payment_outlined, 'Payments'),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(IconData icon, String label) {
    return Expanded(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        color: AppColors.cardBackground,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: AppColors.primary, size: 28.sp),
              SizedBox(height: 8.h),
              Text(
                label,
                textAlign: TextAlign.center,
                style: AppFonts.bodySmall.copyWith(color: AppColors.textDark, fontWeight: FontWeight.w500, fontSize: 13.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Text(
        title,
        style: AppFonts.caption.copyWith(color: AppColors.textHint, fontWeight: FontWeight.w600, letterSpacing: 0.5),
      ),
    );
  }

  Widget _buildProfileListItem(ProfileController controller, IconData icon, String title, VoidCallback onTap, {bool showTrailingIcon = true, Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.textMedium, size: 22.sp),
      title: Text(title, style: AppFonts.bodyLarge.copyWith(color: color ?? AppColors.textDark, fontWeight: FontWeight.w500)),
      trailing: showTrailingIcon ? Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.mediumGrey) : null,
      onTap: onTap,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
    );
  }

  Widget _buildFooter(ProfileController controller) {
    return Center(
      child: Text(
        controller.appVersion,
        style: AppFonts.caption.copyWith(color: AppColors.textHint, fontSize: 12.sp),
      ),
    );
  }
}
