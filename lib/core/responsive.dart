import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Responsive {
  static init(BuildContext context) {
    return ScreenUtil.init(
      context,
      designSize: const Size(375, 812), // iPhone X size
      minTextAdapt: true,
      splitScreenMode: true,
    );
  }

  // Screen dimensions
  static double get screenWidth => ScreenUtil().screenWidth;
  static double get screenHeight => ScreenUtil().screenHeight;
  static double get statusBarHeight => ScreenUtil().statusBarHeight;
  static double get bottomBarHeight => ScreenUtil().bottomBarHeight;

  // Responsive values
  static double size(double size) => size.w;
  static double height(double height) => height.h;
  static double width(double width) => width.w;
  static double fontSize(double fontSize) => fontSize.sp;
}
