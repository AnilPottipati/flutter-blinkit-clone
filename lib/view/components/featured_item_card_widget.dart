import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import '../../data/model/featured_item_model.dart';

class FeaturedItemCardWidget extends StatelessWidget {
  final FeaturedItem item;
  final VoidCallback? onTap;

  const FeaturedItemCardWidget({
    super.key,
    required this.item,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280.w, // Adjust width as needed, or make it flexible
        margin: EdgeInsets.only(right: 12.w), // Spacing between cards
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              CachedNetworkImage(
                imageUrl: item.imageUrl,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(color: AppColors.lightGrey.withOpacity(0.5)),
                errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: AppColors.mediumGrey),
              ),

              // Overlay content (Tag, Title, Subtitle, Logo)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    // Optional: Add a subtle gradient overlay for better text readability
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.0),
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                ),
              ),

              // Tag
              Positioned(
                top: 8.h,
                left: 8.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: item.tag == "Brand In Focus" ? AppColors.accent.withOpacity(0.85) : AppColors.primary.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    item.tag,
                    style: AppFonts.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10.sp),
                  ),
                ),
              ),

              // Content (Title, Subtitle, Logo)
              Positioned(
                bottom: 10.h,
                left: 12.w,
                right: 12.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      item.title,
                      style: AppFonts.title2.copyWith(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w700),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.subtitle != null)
                      Padding(
                        padding: EdgeInsets.only(top: 4.h),
                        child: Text(
                          item.subtitle!,
                          style: AppFonts.bodyMedium.copyWith(color: Colors.white.withOpacity(0.9), fontSize: 13.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              ),

              // Optional Logo (e.g., MIVI)
              if (item.logoUrl != null)
                Positioned(
                  top: 40.h, // Adjust position as needed
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: item.logoUrl!,
                      height: 30.h, // Adjust size as needed
                      width: 70.w,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const SizedBox.shrink(),
                      errorWidget: (context, url, error) => const SizedBox.shrink(),
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
