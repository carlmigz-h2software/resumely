import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class SkillChip extends StatelessWidget {
  final String label;
  final VoidCallback? onDeleted;
  final bool isSelected;
  final VoidCallback? onTap;

  const SkillChip({
    super.key,
    required this.label,
    this.onDeleted,
    this.isSelected = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 6.h,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary.withValues(alpha: 0.15) : AppColors.secondary,
        borderRadius: BorderRadius.circular(999.r),
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.bodySmall.copyWith(
              color: isSelected ? AppColors.primary : AppColors.foreground,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (onDeleted != null) ...[
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: onDeleted,
              child: Container(
                width: 16.r,
                height: 16.r,
                decoration: const BoxDecoration(
                  color: AppColors.muted,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close_rounded,
                  size: 10.r,
                  color: AppColors.foreground,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
