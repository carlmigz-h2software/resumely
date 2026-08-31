import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/app_icon_button.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class PreviewHeader extends StatelessWidget {
  final String title;
  final VoidCallback onBack;
  final VoidCallback onExport;

  const PreviewHeader({
    super.key,
    required this.title,
    required this.onBack,
    required this.onExport,
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
                Text(
                  AppStrings.preview.toUpperCase(),
                  style: AppTextStyles.overline,
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
          GradientButton(
            width: 120.w,
            height: 38.h,
            onPressed: onExport,
            text: AppStrings.exportPdf,
            icon: AppIcon(
              icon: AppIcons.fileText,
              size: 14.r,
              color: AppColors.primaryForeground,
            ),
          ),
        ],
      ),
    );
  }
}
