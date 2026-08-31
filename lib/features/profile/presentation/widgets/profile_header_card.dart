import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class ProfileHeaderCard extends StatelessWidget {
  final String name;
  final String email;
  final String title;

  const ProfileHeaderCard({
    super.key,
    required this.name,
    required this.email,
    this.title = 'Senior Product Designer',
  });

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .map((p) => p.isNotEmpty ? p[0] : '')
        .take(2)
        .join()
        .toUpperCase();

    return CardContainer(
      isGradient: true,
      child: Row(
        children: [
          Container(
            width: 56.r,
            height: 56.r,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: AppSpacing.borderRadiusMd,
              boxShadow: AppColors.primaryGlow,
            ),
            child: Center(
              child: Text(
                initials.isNotEmpty ? initials : 'RC',
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.primaryForeground,
                ),
              ),
            ),
          ),
          AppSpacing.h16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyLarge.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  email,
                  style: AppTextStyles.caption,
                ),
                SizedBox(height: 4.h),
                Text(
                  title,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
