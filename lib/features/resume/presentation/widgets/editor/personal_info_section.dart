import 'package:flutter/material.dart';
import 'package:resumely/app/components/accordion_section.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class PersonalInfoSection extends StatelessWidget {
  final ResumeEntity resume;
  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<ResumeEntity> onChanged;

  const PersonalInfoSection({
    super.key,
    required this.resume,
    required this.isOpen,
    required this.onToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: AppStrings.personalInfo,
      icon: AppIcons.fileUser,
      isOpen: isOpen,
      onToggle: onToggle,
      child: Column(
        children: [
          CustomTextField(
            label: AppStrings.fullName,
            initialValue: resume.fullName,
            hintText: 'Jane Doe',
            onChanged: (v) => onChanged(resume.copyWith(fullName: v)),
          ),
          AppSpacing.v10,
          CustomTextField(
            label: AppStrings.jobTitle,
            initialValue: resume.title,
            hintText: AppStrings.jobTitlePlaceholder,
            onChanged: (v) => onChanged(resume.copyWith(title: v)),
          ),
          AppSpacing.v10,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: AppStrings.email,
                  initialValue: resume.email,
                  hintText: 'you@email.com',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (v) => onChanged(resume.copyWith(email: v)),
                ),
              ),
              AppSpacing.h10,
              Expanded(
                child: CustomTextField(
                  label: AppStrings.phone,
                  initialValue: resume.phone,
                  hintText: AppStrings.phonePlaceholder,
                  keyboardType: TextInputType.phone,
                  onChanged: (v) => onChanged(resume.copyWith(phone: v)),
                ),
              ),
            ],
          ),
          AppSpacing.v10,
          CustomTextField(
            label: AppStrings.location,
            initialValue: resume.location,
            hintText: AppStrings.locationPlaceholder,
            onChanged: (v) => onChanged(resume.copyWith(location: v)),
          ),
          AppSpacing.v10,
          CustomTextField(
            label: AppStrings.website,
            initialValue: resume.website,
            hintText: AppStrings.websitePlaceholder,
            onChanged: (v) => onChanged(resume.copyWith(website: v)),
          ),
        ],
      ),
    );
  }
}
