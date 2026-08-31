import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/accordion_section.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/skill_chip.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

class SkillsSection extends StatefulWidget {
  final ResumeEntity resume;
  final bool isOpen;
  final VoidCallback onToggle;
  final ValueChanged<ResumeEntity> onChanged;

  const SkillsSection({
    super.key,
    required this.resume,
    required this.isOpen,
    required this.onToggle,
    required this.onChanged,
  });

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addSkill() {
    final text = _controller.text.trim();
    if (text.isNotEmpty && !widget.resume.skills.contains(text)) {
      widget.onChanged(
        widget.resume.copyWith(
          skills: [...widget.resume.skills, text],
        ),
      );
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AccordionSection(
      title: AppStrings.skillsAndTools,
      icon: AppIcons.sparkles,
      isOpen: widget.isOpen,
      count: widget.resume.skills.length,
      onToggle: widget.onToggle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  controller: _controller,
                  hintText: AppStrings.skillPlaceholder,
                ),
              ),
              AppSpacing.h8,
              GradientButton(
                width: 70.w,
                height: 48.h,
                onPressed: _addSkill,
                text: AppStrings.addSkill,
                isGlow: false,
              ),
            ],
          ),
          if (widget.resume.skills.isNotEmpty) ...[
            AppSpacing.v12,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: widget.resume.skills
                  .map(
                    (s) => SkillChip(
                      label: s,
                      onDeleted: () {
                        final updated = List<String>.from(widget.resume.skills)..remove(s);
                        widget.onChanged(widget.resume.copyWith(skills: updated));
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
