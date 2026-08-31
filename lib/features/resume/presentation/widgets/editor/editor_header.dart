import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class EditorHeader extends StatelessWidget {
  final String title;
  final bool isSaving;
  final bool isSaved;
  final VoidCallback onBack;
  final VoidCallback onPreview;

  const EditorHeader({
    super.key,
    required this.title,
    required this.isSaving,
    required this.isSaved,
    required this.onBack,
    required this.onPreview,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        children: [
          AppIconButton(
            icon: Icons.arrow_back_rounded,
            size: 36.r,
            iconSize: 18.r,
            backgroundColor: AppColors.secondary,
            color: AppColors.foreground,
            onTap: onBack,
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.editing.toUpperCase(),
                      style: AppTextStyles.overline,
                    ),
                    if (isSaving) ...[
                      Text(' · ', style: AppTextStyles.overline),
                      SizedBox(
                        width: 10.r,
                        height: 10.r,
                        child: const CircularProgressIndicator(
                          strokeWidth: 1.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.mutedForeground,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(AppStrings.saving, style: AppTextStyles.overline),
                    ] else if (isSaved) ...[
                      Text(' · ', style: AppTextStyles.overline),
                      Icon(Icons.check, size: 12.r, color: AppColors.success),
                      SizedBox(width: 2.w),
                      Text(
                        AppStrings.saved,
                        style: AppTextStyles.overline.copyWith(color: AppColors.success),
                      ),
                    ],
                  ],
                ),
                Text(
                  title.isNotEmpty ? title : AppStrings.untitledResume,
                  style: AppTextStyles.h4,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onPreview,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(999.r),
                boxShadow: AppColors.primaryGlow,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.visibility_outlined,
                    size: 14.r,
                    color: AppColors.primaryForeground,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    AppStrings.preview,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.primaryForeground,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
