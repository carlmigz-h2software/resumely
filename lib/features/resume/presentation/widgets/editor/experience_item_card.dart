import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class ExperienceItemCard extends StatelessWidget {
  final int index;
  final ExperienceEntity experience;
  final ValueChanged<ExperienceEntity> onChanged;
  final VoidCallback onDelete;

  const ExperienceItemCard({
    super.key,
    required this.index,
    required this.experience,
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
            label: AppStrings.role,
            initialValue: experience.role,
            onChanged: (v) => onChanged(experience.copyWith(role: v)),
          ),
          AppSpacing.v8,
          CustomTextField(
            label: AppStrings.company,
            initialValue: experience.company,
            onChanged: (v) => onChanged(experience.copyWith(company: v)),
          ),
          AppSpacing.v8,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: AppStrings.startYear,
                  initialValue: experience.start,
                  hintText: '2022',
                  onChanged: (v) => onChanged(experience.copyWith(start: v)),
                ),
              ),
              AppSpacing.h10,
              Expanded(
                child: CustomTextField(
                  label: AppStrings.endYear,
                  initialValue: experience.end,
                  hintText: 'Present',
                  onChanged: (v) => onChanged(experience.copyWith(end: v)),
                ),
              ),
            ],
          ),
          AppSpacing.v8,
          CustomTextField(
            label: AppStrings.description,
            initialValue: experience.description,
            hintText: AppStrings.descriptionPlaceholder,
            maxLines: 3,
            onChanged: (v) => onChanged(experience.copyWith(description: v)),
          ),
        ],
      ),
    );
  }
}
