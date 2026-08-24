import 'package:flutter/material.dart';
import 'package:resumely/app/constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData themeData = ThemeData(
    fontFamily: 'SpaceGrotesk',
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
  );
}
