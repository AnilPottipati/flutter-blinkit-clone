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
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => _buildLocationSheet(context),
                          );
                        },
                        child: Row(
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

  Widget _buildLocationSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Text(
                      'Select delivery location',
                      style: AppFonts.title2.copyWith(fontSize: 18.sp),
                    ),
                    Positioned(
                      left: -10,
                      top: -10,
                      child: IconButton(
                        icon: Icon(Icons.close, color: AppColors.textDark),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for area, street name...',
                        prefixIcon:
                            Icon(Icons.search, color: AppColors.textHint),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppColors.lightGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppColors.lightGrey),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          _buildLocationOptionTile(
                            icon: Icons.gps_fixed,
                            iconColor: AppColors.primary,
                            title: 'Use current location',
                            subtitle:
                                'Capital Park, Ayyappa Society, Madhapur...',
                            onTap: () {},
                          ),
                          Divider(height: 1.h, indent: 50.w, color: AppColors.lightGrey.withOpacity(0.5)),
                          _buildLocationOptionTile(
                            icon: Icons.add,
                            iconColor: AppColors.primary,
                            title: 'Add new address',
                            onTap: () {},
                          ),
                          Divider(height: 1.h, indent: 50.w, color: AppColors.lightGrey.withOpacity(0.5)),
                          _buildLocationOptionTile(
                            icon: Icons.message,
                            iconColor: Colors.green,
                            title: 'Request address from someone else',
                            onTap: () {},
                          ),
                          Divider(height: 1.h, indent: 50.w, color: AppColors.lightGrey.withOpacity(0.5)),
                          ListTile(
                            leading: Container(
                              width: 24.w,
                              height: 24.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFE51A32),
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'zomato',
                                style: AppFonts.caption.copyWith(
                                    color: Colors.white,
                                    fontSize: 6.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            title: Text('Import your addresses from Zomato',
                                style: AppFonts.bodyMedium),
                            trailing: Icon(Icons.arrow_forward_ios,
                                size: 16.sp, color: AppColors.textHint),
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text('Your saved addresses',
                        style: AppFonts.bodySmall
                            .copyWith(color: AppColors.textSecondary)),
                    SizedBox(height: 16.h),
                    _buildSavedAddressCard(
                      icon: Icons.home_outlined,
                      title: 'Home',
                      distance: '20.37 km away',
                      address:
                          'Charan, Hno 2-20-97/92/2, Kaveri Nagar, Sai Nagar, Uppal, Hyderabad',
                      phone: 'Phone number: 7989917291',
                    ),
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEA),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFFFE082)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.upload_outlined,
                              color: AppColors.textDark),
                          SizedBox(width: 12.w),
                          Expanded(
                              child: Text(
                                  'Now share your addresses with friends and family',
                                  style: AppFonts.bodySmall)),
                          Icon(Icons.close,
                              size: 18.sp, color: AppColors.textHint),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildSavedAddressCard(
                      icon: Icons.location_on_outlined,
                      title: 'College',
                      distance: '30.18 km away',
                      address:
                          'Anurag university, Anurag University, Venkatapur, Ghatkesar, Medchal Malkajgiri District, Hyderabad, Telangana',
                      phone: null,
                    ),
                     SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationOptionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24.sp),
      title: Text(title,
          style: AppFonts.bodyMedium
              .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
      subtitle: subtitle != null
          ? Text(subtitle,
              style: AppFonts.caption.copyWith(color: AppColors.textSecondary),
              maxLines: 1,
              overflow: TextOverflow.ellipsis)
          : null,
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.textHint),
      onTap: onTap,
    );
  }

  Widget _buildSavedAddressCard({
    required IconData icon,
    required String title,
    required String distance,
    required String address,
    String? phone,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.lightGrey.withOpacity(0.7)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.lightGrey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 24.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: AppFonts.body1Strong),
                    SizedBox(width: 8.w),
                    Text(distance,
                        style: AppFonts.caption.copyWith(color: AppColors.primary)),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(address,
                    style: AppFonts.bodySmall.copyWith(color: AppColors.textMedium)),
                if (phone != null) ...[
                  SizedBox(height: 4.h),
                  Text(phone,
                      style:
                          AppFonts.bodySmall.copyWith(color: AppColors.textMedium)),
                ],
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.more_horiz, color: AppColors.textHint),
                    SizedBox(width: 16.w),
                    Icon(Icons.upload_outlined, color: AppColors.textHint),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
