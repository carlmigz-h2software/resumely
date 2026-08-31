import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class ProfilePhotoCard extends StatelessWidget {
  final VoidCallback? onPickPhoto;

  const ProfilePhotoCard({super.key, this.onPickPhoto});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      isGradient: true,
      onTap: onPickPhoto,
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 70.r,
                height: 70.r,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: AppSpacing.borderRadiusLg,
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: AppIcon(
                    icon: AppIcons.user,
                    size: 32.r,
                    color: AppColors.mutedForeground,
                  ),
                ),
              ),
              Positioned(
                right: -2,
                bottom: -2,
                child: Container(
                  width: 26.r,
                  height: 26.r,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: AppColors.primaryGlow,
                  ),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    size: 14.r,
                    color: AppColors.primaryForeground,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.h16,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.profilePhoto,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  AppStrings.profilePhotoHint,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
