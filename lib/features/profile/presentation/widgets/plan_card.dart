import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/status_badge.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class PlanCard extends StatelessWidget {
  final String name;
  final String price;
  final String period;
  final List<String> features;
  final bool isCurrent;
  final bool isPopular;
  final VoidCallback? onSelect;

  const PlanCard({
    super.key,
    required this.name,
    required this.price,
    required this.period,
    required this.features,
    this.isCurrent = false,
    this.isPopular = false,
    this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: isPopular ? AppColors.primary.withValues(alpha: 0.06) : AppColors.surface,
        borderRadius: AppSpacing.borderRadiusLg,
        border: Border.all(
          color: isPopular ? AppColors.primary.withValues(alpha: 0.6) : AppColors.border,
          width: isPopular ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(name, style: AppTextStyles.h4),
                  if (isCurrent) ...[
                    SizedBox(width: 8.w),
                    const StatusBadge(
                      label: 'CURRENT',
                      color: AppColors.success,
                    ),
                  ],
                  if (isPopular) ...[
                    SizedBox(width: 8.w),
                    const StatusBadge(
                      label: 'POPULAR',
                      color: AppColors.primary,
                    ),
                  ],
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(price, style: AppTextStyles.h3),
                  Text(period, style: AppTextStyles.caption),
                ],
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text('Billed monthly', style: AppTextStyles.caption),
          AppSpacing.v12,
          Column(
            children: features.map((f) {
              return Padding(
                padding: EdgeInsets.only(bottom: 6.h),
                child: Row(
                  children: [
                    Icon(Icons.check_rounded, size: 14.r, color: AppColors.success),
                    AppSpacing.h8,
                    Text(f, style: AppTextStyles.bodySmall),
                  ],
                ),
              );
            }).toList(),
          ),
          if (!isCurrent) ...[
            AppSpacing.v12,
            GradientButton(
              onPressed: onSelect ?? () {},
              text: 'Upgrade to $name',
              height: 40.h,
              isGlow: isPopular,
            ),
          ],
        ],
      ),
    );
  }
}
