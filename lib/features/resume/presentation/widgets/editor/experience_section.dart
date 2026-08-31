import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/accordion_section.dart';
import 'package:resumely/app/components/secondary_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/experience_item_card.dart';
import 'package:uuid/uuid.dart';

class ExperienceSection extends StatelessWidget {
  final ResumeEntity resume;
  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<ResumeEntity> onChanged;

  const ExperienceSection({
    super.key,
    required this.resume,
    required this.isOpen,
    required this.onToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: AppStrings.workExperience,
      icon: AppIcons.briefcase,
      isOpen: isOpen,
      count: resume.experiences.length,
      onToggle: onToggle,
      child: Column(
        children: [
          for (int i = 0; i < resume.experiences.length; i++) ...[
            ExperienceItemCard(
              index: i + 1,
              experience: resume.experiences[i],
              onChanged: (updatedExp) {
                final list = List<ExperienceEntity>.from(resume.experiences);
                list[i] = updatedExp;
                onChanged(resume.copyWith(experiences: list));
              },
              onDelete: () {
                final list = List<ExperienceEntity>.from(resume.experiences)..removeAt(i);
                onChanged(resume.copyWith(experiences: list));
              },
            ),
            AppSpacing.v10,
          ],
          SecondaryButton(
            onPressed: () {
              const uuid = Uuid();
              final newExp = ExperienceEntity(
                id: uuid.v4(),
                role: '',
                company: '',
                start: '',
                end: '',
                description: '',
              );
              onChanged(
                resume.copyWith(
                  experiences: [...resume.experiences, newExp],
                ),
              );
            },
            text: AppStrings.addExperience,
            icon: Icon(Icons.add, size: 16.r, color: AppColors.mutedForeground),
            backgroundColor: Colors.transparent,
            borderColor: AppColors.border,
          ),
        ],
      ),
    );
  }
}
