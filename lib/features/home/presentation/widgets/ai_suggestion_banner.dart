import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class AiSuggestionBanner extends StatelessWidget {
  final String title;
  final String description;
  final String actionText;
  final VoidCallback onApply;

  const AiSuggestionBanner({
    super.key,
    this.title = AppStrings.aiSuggestion,
    this.description = AppStrings.aiSuggestionText,
    this.actionText = AppStrings.applySuggestion,
    required this.onApply,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppIcon(
            icon: AppIcons.sparkles,
            size: 18.r,
            color: AppColors.primaryForeground,
            containerSize: 36.r,
            backgroundGradient: AppColors.primaryGradient,
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.h4,
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: AppTextStyles.caption.copyWith(
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: onApply,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        actionText,
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 14.r,
                        color: AppColors.primary,
                      ),
                    ],
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
