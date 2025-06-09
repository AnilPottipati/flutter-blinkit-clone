import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/top_category.dart';
import './top_category_icon_strip.dart';

class HomeCustomSliverAppBar extends StatelessWidget {
  final Color? backgroundColor;
  final Color itemColor;
  final Color searchIconColor;
  final Color categoryStripItemColor;
  final double expandedHeight;
  final List<TopCategory> sampleTopCategories;
  final VoidCallback? onWalletPressed;
  final VoidCallback? onSearchTap;
  final bool showCategoryStrip;

  const HomeCustomSliverAppBar({
    super.key,
    required this.backgroundColor,
    required this.itemColor,
    required this.searchIconColor,
    required this.categoryStripItemColor,
    required this.expandedHeight,
    required this.sampleTopCategories,
    this.onWalletPressed,
    this.onSearchTap,
    required this.showCategoryStrip,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      snap: true,
      automaticallyImplyLeading: false,
      backgroundColor: backgroundColor,
      elevation: 0,
      expandedHeight: expandedHeight,
      actions: [
        IconButton(
          icon: Icon(
            Icons.account_balance_wallet_outlined,
            color: itemColor,
            size: 24.sp,
          ),
          onPressed: onWalletPressed,
        ),
        SizedBox(width: 8.w),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(
          showCategoryStrip
              ? (60.h + 100.h)
              : 60.h, // Search bar height + optional Icon strip height
        ),
        child: Container(
          color:
              backgroundColor, // Animated background for the bottom pinned section
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search "travel essentials"',
                    hintStyle: AppFonts.bodyMedium.copyWith(
                      color: searchIconColor,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: searchIconColor,
                      size: 22.sp,
                    ),
                    suffixIcon: Icon(
                      Icons.mic_none,
                      color: searchIconColor,
                      size: 22.sp,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 10.h,
                      horizontal: 15.w,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
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
                  style: AppFonts.bodyMedium.copyWith(
                    color: AppColors.textDark,
                  ),
                  onTap: onSearchTap,
                ),
              ),
              if (showCategoryStrip)
                TopCategoryIconStrip(
                  categories: sampleTopCategories,
                  iconColor: categoryStripItemColor,
                ),
              if (showCategoryStrip)
                SizedBox(
                  height: 0.h,
                ), // Ensures consistent spacing if needed, can be adjusted or removed
            ],
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary, // Keep original gradient start
                AppColors.primary.withAlpha(204), // Keep original gradient end
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top, // For status bar
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height:
                      kToolbarHeight +
                      35.h, // Explicit height for the text section
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Blinkit in',
                        style: AppFonts.caption.copyWith(
                          color: Colors.white70,
                          fontSize: 12.sp,
                        ),
                      ),
                      Text(
                        '10 minutes',
                        style: AppFonts.heading3.copyWith(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "VIP Hills, Madhapur...",
                            style: AppFonts.bodySmall.copyWith(
                              color: Colors.white,
                              fontSize: 13.sp,
                            ),
                            softWrap: false,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
