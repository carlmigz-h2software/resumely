import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/accordion_section.dart';
import 'package:resumely/app/components/secondary_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/education_item_card.dart';
import 'package:uuid/uuid.dart';

class EducationSection extends StatelessWidget {
  final ResumeEntity resume;
  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<ResumeEntity> onChanged;

  const EducationSection({
    super.key,
    required this.resume,
    required this.isOpen,
    required this.onToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: AppStrings.education,
      icon: AppIcons.graduationCap,
      isOpen: isOpen,
      count: resume.educations.length,
      onToggle: onToggle,
      child: Column(
        children: [
          for (int i = 0; i < resume.educations.length; i++) ...[
            EducationItemCard(
              index: i + 1,
              education: resume.educations[i],
              onChanged: (updatedEdu) {
                final list = List<EducationEntity>.from(resume.educations);
                list[i] = updatedEdu;
                onChanged(resume.copyWith(educations: list));
              },
              onDelete: () {
                final list = List<EducationEntity>.from(resume.educations)..removeAt(i);
                onChanged(resume.copyWith(educations: list));
              },
            ),
            AppSpacing.v10,
          ],
          SecondaryButton(
            onPressed: () {
              const uuid = Uuid();
              final newEdu = EducationEntity(
                id: uuid.v4(),
                school: '',
                degree: '',
                start: '',
                end: '',
              );
              onChanged(
                resume.copyWith(
                  educations: [...resume.educations, newEdu],
                ),
              );
            },
            text: AppStrings.addEducation,
            icon: Icon(Icons.add, size: 16.r, color: AppColors.mutedForeground),
            backgroundColor: Colors.transparent,
            borderColor: AppColors.border,
          ),
        ],
      ),
    );
  }
}
