import 'package:flutter/material.dart';
import 'app_colors.dart'; // Adjust path based on your project structure

class AppTextStyles {
  AppTextStyles._();

  static const String _fontFamily = 'SpaceGrotesk';

  // Base TextStyle helper
  static TextStyle _baseStyle({
    required double fontSize,
    required Color color,
    required FontWeight fontWeight,
  }) {
    return TextStyle(
      fontFamily: _fontFamily,
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
    );
  }

  // ==================== WHITE STYLES ====================
  // Normal (w400)
  static TextStyle get white8Normal => _baseStyle(
    fontSize: 8,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get white10Normal => _baseStyle(
    fontSize: 10,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get white12Normal => _baseStyle(
    fontSize: 12,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get white14Normal => _baseStyle(
    fontSize: 14,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get white16Normal => _baseStyle(
    fontSize: 16,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get white18Normal => _baseStyle(
    fontSize: 18,
    color: AppColors.white,
    fontWeight: FontWeight.w400,
  );

  // Bold (w700)
  static TextStyle get white8Bold => _baseStyle(
    fontSize: 8,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get white10Bold => _baseStyle(
    fontSize: 10,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get white12Bold => _baseStyle(
    fontSize: 12,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get white14Bold => _baseStyle(
    fontSize: 14,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get white16Bold => _baseStyle(
    fontSize: 16,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get white18Bold => _baseStyle(
    fontSize: 18,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
  );

  // ==================== BLACK STYLES ====================
  // Normal (w400)
  static TextStyle get black8Normal => _baseStyle(
    fontSize: 8,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get black10Normal => _baseStyle(
    fontSize: 10,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get black12Normal => _baseStyle(
    fontSize: 12,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get black14Normal => _baseStyle(
    fontSize: 14,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get black16Normal => _baseStyle(
    fontSize: 16,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get black18Normal => _baseStyle(
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeight.w400,
  );

  // Bold (w700)
  static TextStyle get black8Bold => _baseStyle(
    fontSize: 8,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get black10Bold => _baseStyle(
    fontSize: 10,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get black12Bold => _baseStyle(
    fontSize: 12,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get black14Bold => _baseStyle(
    fontSize: 14,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get black16Bold => _baseStyle(
    fontSize: 16,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get black18Bold => _baseStyle(
    fontSize: 18,
    color: AppColors.black,
    fontWeight: FontWeight.bold,
  );

  // ==================== GRAY STYLES ====================
  // Normal (w400)
  static TextStyle get gray8Normal => _baseStyle(
    fontSize: 8,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get gray10Normal => _baseStyle(
    fontSize: 10,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get gray12Normal => _baseStyle(
    fontSize: 12,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get gray14Normal => _baseStyle(
    fontSize: 14,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get gray16Normal => _baseStyle(
    fontSize: 16,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );
  static TextStyle get gray18Normal => _baseStyle(
    fontSize: 18,
    color: AppColors.gray,
    fontWeight: FontWeight.w400,
  );

  // Bold (w700)
  static TextStyle get gray8Bold => _baseStyle(
    fontSize: 8,
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get gray10Bold => _baseStyle(
    fontSize: 10,
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get gray12Bold => _baseStyle(
    fontSize: 12,
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get gray14Bold => _baseStyle(
    fontSize: 14,
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get gray16Bold => _baseStyle(
    fontSize: 16,
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
  );
  static TextStyle get gray18Bold => _baseStyle(
    fontSize: 18,
    color: AppColors.gray,
    fontWeight: FontWeight.bold,
  );
}
