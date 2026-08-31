import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/circular_progress_badge.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class ActiveResumeCard extends StatelessWidget {
  final String title;
  final int completionPercentage;
  final VoidCallback onEdit;
  final VoidCallback onPreview;

  const ActiveResumeCard({
    super.key,
    required this.title,
    required this.completionPercentage,
    required this.onEdit,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      isGradient: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.currentResume.toUpperCase(),
                      style: AppTextStyles.overline.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      title.isNotEmpty ? title : 'Senior Product Designer',
                      style: AppTextStyles.h3,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Updated recently',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ),
              CircularProgressBadge(
                percentage: completionPercentage.toDouble(),
                size: 54,
              ),
            ],
          ),
          AppSpacing.v16,
          Row(
            children: [
              Expanded(
                child: GradientButton(
                  onPressed: onEdit,
                  text: AppStrings.continueEditing,
                  height: 42.h,
                  isGlow: false,
                ),
              ),
              AppSpacing.h8,
              Container(
                width: 42.h,
                height: 42.h,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                child: IconButton(
                  icon: Icon(
                    Icons.download_rounded,
                    size: 18.r,
                    color: AppColors.foreground,
                  ),
                  onPressed: onPreview,
                  tooltip: 'Preview & Export',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
