import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/colors.dart';
import '../../core/fonts.dart';
import 'package:get/get.dart'; // Import GetX
import '../../data/controller/featured_controller.dart'; // Import the controller
import './featured_item_card_widget.dart';
// Removed unused import for '../../data/model/featured_item.dart';

class FeaturedSectionWidget extends StatelessWidget {
  FeaturedSectionWidget({super.key});

  // Initialize the controller
  final FeaturedController controller = Get.put(FeaturedController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Text(
            'Featured this week',
            style: AppFonts.title2.copyWith(color: AppColors.textDark),
          ),
        ),
        GetX<FeaturedController>(
          builder: (controller) {
            if (controller.isLoading.value) {
              return SizedBox(
                height: 180.h,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (controller.featuredItems.isEmpty) {
              return SizedBox(
                height: 180.h,
                child: const Center(child: Text('No featured items available.')),
              );
            }
            return SizedBox(
              height: 180.h, // Adjust height as needed for the cards
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 16.w, right: 4.w), // Right padding for last item's margin
                itemCount: controller.featuredItems.length,
                itemBuilder: (context, index) {
                  final item = controller.featuredItems[index];
                  return FeaturedItemCardWidget(
                    title: item.title,
                    subtitle: item.subtitle,
                    imageUrl: item.imageUrl,
                    onTap: () {
                      // TODO: Handle featured item tap
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
