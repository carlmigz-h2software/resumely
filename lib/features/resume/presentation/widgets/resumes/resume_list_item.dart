import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/app_icon.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/status_badge.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class ResumeListItem extends StatelessWidget {
  final ResumeEntity resume;
  final VoidCallback onTap;
  final VoidCallback onPreview;
  final VoidCallback onDelete;

  const ResumeListItem({
    super.key,
    required this.resume,
    required this.onTap,
    required this.onPreview,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      onTap: onTap,
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          AppIcon(
            icon: AppIcons.fileText,
            size: 20.r,
            color: AppColors.primary,
            containerSize: 44.r,
            backgroundColor: AppColors.secondary,
            borderRadius: AppSpacing.borderRadiusSm,
            border: Border.all(color: AppColors.border, width: 1),
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resume.title.isNotEmpty ? resume.title : 'Untitled Resume',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    StatusBadge(label: resume.tag),
                    AppSpacing.h8,
                    Text(
                      '${resume.completionPercentage}% complete',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert_rounded,
              color: AppColors.mutedForeground,
              size: 20.r,
            ),
            color: AppColors.surfaceElevated,
            shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
            onSelected: (val) {
              if (val == 'edit') {
                onTap();
              } else if (val == 'preview') {
                onPreview();
              } else if (val == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'preview', child: Text('Preview / Export')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: AppColors.destructive)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
