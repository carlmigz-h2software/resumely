import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class ExportRecordTile extends StatelessWidget {
  final String name;
  final String format;
  final String subtitle;
  final VoidCallback? onDownload;

  const ExportRecordTile({
    super.key,
    required this.name,
    this.format = 'PDF',
    this.subtitle = 'PDF · Just now',
    this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          AppIcon(
            icon: AppIcons.fileText,
            size: 18.r,
            color: AppColors.primary,
            containerSize: 36.r,
            backgroundColor: AppColors.primary.withValues(alpha: 0.15),
            borderRadius: AppSpacing.borderRadiusSm,
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.bodyMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(
              Icons.download_rounded,
              size: 18.r,
              color: AppColors.mutedForeground,
            ),
            onPressed: onDownload,
          ),
        ],
      ),
    );
  }
}
