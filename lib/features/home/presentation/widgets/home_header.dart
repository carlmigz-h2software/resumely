import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  final VoidCallback onCreateResume;

  const HomeHeader({
    super.key,
    required this.userName,
    required this.onCreateResume,
  });

  @override
  Widget build(BuildContext context) {
    final firstName = userName.split(' ').first;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.welcomeBack,
              style: AppTextStyles.caption,
            ),
            SizedBox(height: 2.h),
            Text(
              '$firstName 👋',
              style: AppTextStyles.h2,
            ),
          ],
        ),
        AppIconButton(
          icon: Icons.add_rounded,
          size: 44.r,
          iconSize: 22.r,
          color: AppColors.primaryForeground,
          gradient: AppColors.primaryGradient,
          boxShadow: AppColors.primaryGlow,
          onTap: onCreateResume,
          tooltip: 'Create Resume',
        ),
      ],
    );
  }
}
