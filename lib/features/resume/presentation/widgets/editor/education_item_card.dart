import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class EducationItemCard extends StatelessWidget {
  final int index;
  final EducationEntity education;
  final ValueChanged<EducationEntity> onChanged;
  final VoidCallback onDelete;

  const EducationItemCard({
    super.key,
    required this.index,
    required this.education,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppSpacing.borderRadiusMd,
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '#$index',
                style: AppTextStyles.overline.copyWith(color: AppColors.primary),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 18.r,
                  color: AppColors.mutedForeground,
                ),
                onPressed: onDelete,
              ),
            ],
          ),
          AppSpacing.v6,
          CustomTextField(
            label: AppStrings.school,
            initialValue: education.school,
            onChanged: (v) => onChanged(education.copyWith(school: v)),
          ),
          AppSpacing.v8,
          CustomTextField(
            label: AppStrings.degree,
            initialValue: education.degree,
            onChanged: (v) => onChanged(education.copyWith(degree: v)),
          ),
          AppSpacing.v8,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: AppStrings.startYear,
                  initialValue: education.start,
                  onChanged: (v) => onChanged(education.copyWith(start: v)),
                ),
              ),
              AppSpacing.h10,
              Expanded(
                child: CustomTextField(
                  label: AppStrings.endYear,
                  initialValue: education.end,
                  onChanged: (v) => onChanged(education.copyWith(end: v)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
