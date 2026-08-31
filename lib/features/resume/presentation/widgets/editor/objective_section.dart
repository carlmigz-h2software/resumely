import 'package:flutter/material.dart';
import 'package:resumely/app/components/accordion_section.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class ObjectiveSection extends StatelessWidget {
  final ResumeEntity resume;
  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<ResumeEntity> onChanged;

  const ObjectiveSection({
    super.key,
    required this.resume,
    required this.isOpen,
    required this.onToggle,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: AppStrings.careerObjective,
      icon: AppIcons.bookOpen,
      isOpen: isOpen,
      onToggle: onToggle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CustomTextField(
            initialValue: resume.objective,
            hintText: AppStrings.objectivePlaceholder,
            maxLines: 4,
            maxLength: 600,
            onChanged: (v) => onChanged(resume.copyWith(objective: v)),
          ),
        ],
      ),
    );
  }
}
