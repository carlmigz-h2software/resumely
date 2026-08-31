import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class ComparisonCard extends StatelessWidget {
  final String title;
  final String beforeText;
  final String afterText;
  final String improvementTag;

  const ComparisonCard({
    super.key,
    required this.title,
    required this.beforeText,
    required this.afterText,
    required this.improvementTag,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyles.h4,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(999.r),
                ),
                child: Text(
                  improvementTag,
                  style: AppTextStyles.overline.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          AppSpacing.v12,

          // Before box
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.destructive.withValues(alpha: 0.06),
              borderRadius: AppSpacing.borderRadiusSm,
              border: Border.all(
                color: AppColors.destructive.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.close_rounded,
                      size: 14.r,
                      color: AppColors.destructive,
                    ),
                    AppSpacing.h6,
                    Text(
                      'BEFORE (Passive)',
                      style: AppTextStyles.overline.copyWith(
                        color: AppColors.destructive,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  beforeText,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondary,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.v10,

          // After box
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: AppSpacing.borderRadiusSm,
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppIcon(
                      icon: AppIcons.sparkles,
                      size: 12.r,
                      color: AppColors.primary,
                    ),
                    AppSpacing.h6,
                    Text(
                      'AFTER AI (Action & Metrics)',
                      style: AppTextStyles.overline.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  afterText,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.foreground,
                    fontWeight: FontWeight.w500,
                    height: 1.35,
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
