import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class EmptyStateWidget extends StatelessWidget {
  final dynamic icon;
  final String title;
  final String? subtitle;
  final String? actionText;
  final VoidCallback? onAction;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppIcon(
              icon: icon,
              size: 36.r,
              color: AppColors.mutedForeground,
              containerSize: 64.r,
              backgroundColor: AppColors.secondary,
              borderRadius: BorderRadius.circular(16.r),
            ),
            AppSpacing.v16,
            Text(
              title,
              style: AppTextStyles.h4,
              textAlign: TextAlign.center,
            ),
            if (subtitle != null) ...[
              AppSpacing.v6,
              Text(
                subtitle!,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.mutedForeground,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (actionText != null && onAction != null) ...[
              AppSpacing.v20,
              GradientButton(
                onPressed: onAction,
                text: actionText!,
                height: 40.h,
                width: 160.w,
                isGlow: false,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
