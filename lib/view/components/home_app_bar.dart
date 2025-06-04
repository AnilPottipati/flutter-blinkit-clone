import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import './top_category_icon_strip.dart'; // Import the strip
import '../../data/model/top_category.dart'; // Import for sample data

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)], // Example gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: AppBar(
      automaticallyImplyLeading: false, // Removes the default back button
      backgroundColor: Colors.transparent, // AppBar is now transparent, container has gradient
      elevation: 0, // No shadow
      titleSpacing: 16.w, // Adjust spacing as needed
      title: Flexible(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Blinkit in',
            style: AppFonts.caption.copyWith(color: Colors.white70, fontSize: 12.sp),
          ),
          Text(
            '10 minutes',
            style: AppFonts.heading3.copyWith(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          Flexible(
            child: Row(
              children: [
                Text(
                  'VIP Hills, Madhapur, Jaihind Enclave',
                  style: AppFonts.bodySmall.copyWith(color: Colors.white, fontSize: 13.sp),
                  overflow: TextOverflow.ellipsis,
                ),
                Icon(Icons.arrow_drop_down, color: Colors.white, size: 20.sp),
              ],
            ),
          ),
        ],
      ),
      ), // Close Flexible widget for title
      actions: [
        IconButton(
          icon: Icon(Icons.account_balance_wallet_outlined, color: Colors.white, size: 24.sp),
          onPressed: () {
            // TODO: Navigate to wallet
          },
        ),
        IconButton(
          icon: Icon(Icons.person_outline, color: Colors.white, size: 24.sp),
          onPressed: () {
            // TODO: Navigate to profile
          },
        ),
        SizedBox(width: 8.w), // For a little spacing before the edge
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(60.h + 100.h), // Search bar height + icon strip height
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              // color: AppColors.primary, // Container for search is now transparent or part of gradient
              child: TextField(
            decoration: InputDecoration(
              hintText: 'Search "travel essentials"',
              hintStyle: AppFonts.bodyMedium.copyWith(color: AppColors.textHintDarkBg),
              prefixIcon: Icon(Icons.search, color: AppColors.textHintDarkBg, size: 22.sp),
              suffixIcon: Icon(Icons.mic_none, color: AppColors.textHintDarkBg, size: 22.sp),
              filled: true,
              fillColor: Colors.white, // Search bar background
              contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none, // No border
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
            ),
            style: AppFonts.bodyMedium.copyWith(color: AppColors.textDark),
            onTap: () {
              // TODO: Handle search tap, maybe navigate to a search screen
            },
          ),
        ),
            TopCategoryIconStrip(categories: sampleTopCategories), // Add the icon strip here
          ],
        ),
      ),
    )); // Close Container for gradient
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 60.h + 100.h); // AppBar height + Search bar + Icon Strip height
}

// Note: textHintDarkBg was already added to AppColors in a previous step.
