import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class SectionProgressTile extends StatelessWidget {
  final dynamic icon;
  final String title;
  final double progress;
  final VoidCallback onTap;

  const SectionProgressTile({
    super.key,
    required this.icon,
    required this.title,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            size: 18.r,
            color: AppColors.primary,
            containerSize: 38.r,
            backgroundColor: AppColors.secondary,
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Container(
                    height: 4.h,
                    width: double.infinity,
                    color: AppColors.muted,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.h12,
          Icon(
            Icons.chevron_right_rounded,
            size: 20.r,
            color: AppColors.mutedForeground,
          ),
        ],
      ),
    );
  }
}
