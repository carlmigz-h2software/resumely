import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/constants/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontDisplay = 'SpaceGrotesk';

  // Display & Headings (Space Grotesk)
  static TextStyle get h1 => TextStyle(
        fontFamily: fontDisplay,
        fontSize: 28.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.foreground,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle get h2 => TextStyle(
        fontFamily: fontDisplay,
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
        letterSpacing: -0.3,
        height: 1.25,
      );

  static TextStyle get h3 => TextStyle(
        fontFamily: fontDisplay,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
        letterSpacing: -0.2,
        height: 1.3,
      );

  static TextStyle get h4 => TextStyle(
        fontFamily: fontDisplay,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
        height: 1.35,
      );

  // Body Styles (Clean Sans)
  static TextStyle get bodyLarge => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.foreground,
        height: 1.4,
      );

  static TextStyle get bodyMedium => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.foreground,
        height: 1.4,
      );

  static TextStyle get bodySmall => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.4,
      );

  static TextStyle get caption => TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.mutedForeground,
        height: 1.3,
      );

  static TextStyle get overline => TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mutedForeground,
        letterSpacing: 1.0,
        height: 1.2,
      );

  // Buttons & Labels
  static TextStyle get buttonText => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.primaryForeground,
      );

  static TextStyle get secondaryButtonText => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.foreground,
      );

  static TextStyle get label => TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.mutedForeground,
      );

  static TextStyle get input => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.foreground,
      );

  static TextStyle get inputPlaceholder => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.mutedForeground.withValues(alpha: 0.6),
      );

  // Legacy Helpers
  static TextStyle get white18Bold => h3;
  static TextStyle get white16Normal => bodyLarge;
  static TextStyle get white14Normal => bodyMedium;
  static TextStyle get gray12Normal => bodySmall;
}
