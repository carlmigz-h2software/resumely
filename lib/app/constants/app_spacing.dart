import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppSpacing {
  AppSpacing._();

  // Spacing Heights (Vertical Gaps)
  static double get gap4 => 4.h;
  static double get gap6 => 6.h;
  static double get gap8 => 8.h;
  static double get gap10 => 10.h;
  static double get gap12 => 12.h;
  static double get gap14 => 14.h;
  static double get gap16 => 16.h;
  static double get gap20 => 20.h;
  static double get gap24 => 24.h;
  static double get gap32 => 32.h;
  static double get gap40 => 40.h;
  static double get gap48 => 48.h;

  // SizedBox Vertical Helpers
  static SizedBox get v4 => SizedBox(height: 4.h);
  static SizedBox get v6 => SizedBox(height: 6.h);
  static SizedBox get v8 => SizedBox(height: 8.h);
  static SizedBox get v10 => SizedBox(height: 10.h);
  static SizedBox get v12 => SizedBox(height: 12.h);
  static SizedBox get v14 => SizedBox(height: 14.h);
  static SizedBox get v16 => SizedBox(height: 16.h);
  static SizedBox get v20 => SizedBox(height: 20.h);
  static SizedBox get v24 => SizedBox(height: 24.h);
  static SizedBox get v32 => SizedBox(height: 32.h);
  static SizedBox get v40 => SizedBox(height: 40.h);
  static SizedBox get v48 => SizedBox(height: 48.h);

  // SizedBox Horizontal Helpers
  static SizedBox get h4 => SizedBox(width: 4.w);
  static SizedBox get h6 => SizedBox(width: 6.w);
  static SizedBox get h8 => SizedBox(width: 8.w);
  static SizedBox get h10 => SizedBox(width: 10.w);
  static SizedBox get h12 => SizedBox(width: 12.w);
  static SizedBox get h16 => SizedBox(width: 16.w);
  static SizedBox get h20 => SizedBox(width: 20.w);
  static SizedBox get h24 => SizedBox(width: 24.w);

  // Paddings
  static EdgeInsets get screenPadding => EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      );

  static EdgeInsets get screenPaddingHorizontal => EdgeInsets.symmetric(
        horizontal: 20.w,
      );

  static EdgeInsets get cardPadding => EdgeInsets.all(16.r);
  static EdgeInsets get cardPaddingDense => EdgeInsets.all(12.r);
  static EdgeInsets get buttonPadding => EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 14.h,
      );

  // Border Radii
  static double get radiusSm => 8.r;
  static double get radiusMd => 12.r;
  static double get radiusLg => 16.r;
  static double get radiusXl => 20.r;
  static double get radius2Xl => 24.r;
  static double get radiusFull => 999.r;

  static BorderRadius get borderRadiusSm => BorderRadius.circular(8.r);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(12.r);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(16.r);
  static BorderRadius get borderRadiusXl => BorderRadius.circular(20.r);
  static BorderRadius get borderRadius2Xl => BorderRadius.circular(24.r);
  static BorderRadius get borderRadiusFull => BorderRadius.circular(999.r);
}
