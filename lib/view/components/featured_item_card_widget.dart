import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/fonts.dart';

class FeaturedItemCardWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;
  final VoidCallback? onTap;

  const FeaturedItemCardWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280.w, 
        margin: EdgeInsets.only(right: 12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withAlpha(77),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end, 
            children: [
              Text(
                title,
                style: AppFonts.title2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp, // Adjusted for prominence
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: AppFonts.bodyMedium.copyWith(color: Colors.white70, fontSize: 12.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
