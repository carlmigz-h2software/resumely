import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // App Logo & Title Brand
        Row(
          children: [
            AppIcon(
              icon: AppIcons.sparkles,
              size: 20.r,
              color: AppColors.primaryForeground,
              containerSize: 40.r,
              backgroundGradient: AppColors.primaryGradient,
              borderRadius: AppSpacing.borderRadiusMd,
              boxShadow: AppColors.primaryGlow,
            ),
            AppSpacing.h10,
            Text(
              AppStrings.appTitle,
              style: AppTextStyles.h3,
            ),
          ],
        ),
        AppSpacing.v32,

        // Page Heading & Subtitle
        Text(
          title,
          style: AppTextStyles.h1,
        ),
        AppSpacing.v6,
        Text(
          subtitle,
          style: AppTextStyles.bodySmall,
        ),
      ],
    );
  }
}
