import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PoweredByBrandsWidget extends StatelessWidget {
  final List<String> brandLogos;
  const PoweredByBrandsWidget({super.key, required this.brandLogos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: brandLogos
            .map((logoUrl) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: Image.network(
                    logoUrl,
                    height: 32.h,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.business, size: 32.h), // Placeholder icon on error
                  ),
                ))
            .toList(),
        ),
      ),
    );
  }
}
