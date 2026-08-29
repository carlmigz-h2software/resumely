import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/accordion_section.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/custom_text_field.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/components/secondary_button.dart';
import 'package:resumely/app/components/skill_chip.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';
import 'package:uuid/uuid.dart';

class EditorPage extends StatefulWidget {
  static const path = '/editor';
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  String _openSection = 'personal';
  final _skillInputController = TextEditingController();

  void _toggleSection(String id) {
    setState(() {
      _openSection = _openSection == id ? '' : id;
    });
  }

  void _updateResume(ResumeEntity updated) {
    context.read<ResumeBloc>().add(ResumeUpdated(updated));
  }

  @override
  void dispose() {
    _skillInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResumeBloc, ResumeState>(
      builder: (context, state) {
        final resume = state.activeResume;
        if (resume == null) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final isSaving = state.status == ResumeStatus.saving;
        final isSaved = state.status == ResumeStatus.saved;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: Column(
              children: [
                // Sticky Header
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: const BoxDecoration(
                    color: AppColors.background,
                    border: Border(
                      bottom: BorderSide(color: AppColors.border, width: 1),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: 18.r,
                            color: AppColors.foreground,
                          ),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      AppSpacing.h12,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppStrings.editing.toUpperCase(),
                                  style: AppTextStyles.overline,
                                ),
                                if (isSaving) ...[
                                  Text(' · ', style: AppTextStyles.overline),
                                  SizedBox(
                                    width: 10.r,
                                    height: 10.r,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 1.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        AppColors.mutedForeground,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(AppStrings.saving, style: AppTextStyles.overline),
                                ] else if (isSaved) ...[
                                  Text(' · ', style: AppTextStyles.overline),
                                  Icon(Icons.check, size: 12.r, color: AppColors.success),
                                  SizedBox(width: 2.w),
                                  Text(
                                    AppStrings.saved,
                                    style: AppTextStyles.overline.copyWith(color: AppColors.success),
                                  ),
                                ],
                              ],
                            ),
                            Text(
                              resume.title.isNotEmpty ? resume.title : AppStrings.untitledResume,
                              style: AppTextStyles.h4,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.push('/preview'),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(999.r),
                            boxShadow: AppColors.primaryGlow,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.visibility_outlined,
                                size: 14.r,
                                color: AppColors.primaryForeground,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                AppStrings.preview,
                                style: AppTextStyles.caption.copyWith(
                                  color: AppColors.primaryForeground,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Editor Sections List
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      children: [
                        // Profile Photo Card
                        CardContainer(
                          isGradient: true,
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: 70.r,
                                    height: 70.r,
                                    decoration: BoxDecoration(
                                      color: AppColors.secondary,
                                      borderRadius: AppSpacing.borderRadiusLg,
                                      border: Border.all(
                                        color: AppColors.primary.withValues(alpha: 0.3),
                                        width: 2,
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.person_rounded,
                                      size: 36.r,
                                      color: AppColors.mutedForeground,
                                    ),
                                  ),
                                  Positioned(
                                    right: -2,
                                    bottom: -2,
                                    child: Container(
                                      width: 26.r,
                                      height: 26.r,
                                      decoration: const BoxDecoration(
                                        gradient: AppColors.primaryGradient,
                                        shape: BoxShape.circle,
                                        boxShadow: AppColors.primaryGlow,
                                      ),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        size: 14.r,
                                        color: AppColors.primaryForeground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.h16,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.profilePhoto,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      AppStrings.profilePhotoHint,
                                      style: AppTextStyles.caption,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.v12,

                        // 1. Personal Info Section
                        AccordionSection(
                          title: AppStrings.personalInfo,
                          icon: Icons.person_outline_rounded,
                          isOpen: _openSection == 'personal',
                          onToggle: () => _toggleSection('personal'),
                          child: Column(
                            children: [
                              CustomTextField(
                                label: AppStrings.fullName,
                                initialValue: resume.fullName,
                                hintText: 'Jane Doe',
                                onChanged: (v) => _updateResume(resume.copyWith(fullName: v)),
                              ),
                              AppSpacing.v10,
                              CustomTextField(
                                label: AppStrings.jobTitle,
                                initialValue: resume.title,
                                hintText: AppStrings.jobTitlePlaceholder,
                                onChanged: (v) => _updateResume(resume.copyWith(title: v)),
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
                                      onChanged: (v) => _updateResume(resume.copyWith(email: v)),
                                    ),
                                  ),
                                  AppSpacing.h10,
                                  Expanded(
                                    child: CustomTextField(
                                      label: AppStrings.phone,
                                      initialValue: resume.phone,
                                      hintText: AppStrings.phonePlaceholder,
                                      keyboardType: TextInputType.phone,
                                      onChanged: (v) => _updateResume(resume.copyWith(phone: v)),
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacing.v10,
                              CustomTextField(
                                label: AppStrings.location,
                                initialValue: resume.location,
                                hintText: AppStrings.locationPlaceholder,
                                onChanged: (v) => _updateResume(resume.copyWith(location: v)),
                              ),
                              AppSpacing.v10,
                              CustomTextField(
                                label: AppStrings.website,
                                initialValue: resume.website,
                                hintText: AppStrings.websitePlaceholder,
                                onChanged: (v) => _updateResume(resume.copyWith(website: v)),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.v12,

                        // 2. Career Objective Section
                        AccordionSection(
                          title: AppStrings.careerObjective,
                          icon: Icons.track_changes_rounded,
                          isOpen: _openSection == 'objective',
                          onToggle: () => _toggleSection('objective'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CustomTextField(
                                initialValue: resume.objective,
                                hintText: AppStrings.objectivePlaceholder,
                                maxLines: 4,
                                maxLength: 600,
                                onChanged: (v) => _updateResume(resume.copyWith(objective: v)),
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.v12,

                        // 3. Work Experience Section
                        AccordionSection(
                          title: AppStrings.workExperience,
                          icon: Icons.work_outline_rounded,
                          isOpen: _openSection == 'experience',
                          count: resume.experiences.length,
                          onToggle: () => _toggleSection('experience'),
                          child: Column(
                            children: [
                              for (int i = 0; i < resume.experiences.length; i++) ...[
                                _ExperienceItemCard(
                                  index: i + 1,
                                  experience: resume.experiences[i],
                                  onChanged: (updatedExp) {
                                    final list = List<ExperienceEntity>.from(resume.experiences);
                                    list[i] = updatedExp;
                                    _updateResume(resume.copyWith(experiences: list));
                                  },
                                  onDelete: () {
                                    final list = List<ExperienceEntity>.from(resume.experiences)
                                      ..removeAt(i);
                                    _updateResume(resume.copyWith(experiences: list));
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
                                  _updateResume(
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
                        ),
                        AppSpacing.v12,

                        // 4. Education Section
                        AccordionSection(
                          title: AppStrings.education,
                          icon: Icons.school_outlined,
                          isOpen: _openSection == 'education',
                          count: resume.educations.length,
                          onToggle: () => _toggleSection('education'),
                          child: Column(
                            children: [
                              for (int i = 0; i < resume.educations.length; i++) ...[
                                _EducationItemCard(
                                  index: i + 1,
                                  education: resume.educations[i],
                                  onChanged: (updatedEdu) {
                                    final list = List<EducationEntity>.from(resume.educations);
                                    list[i] = updatedEdu;
                                    _updateResume(resume.copyWith(educations: list));
                                  },
                                  onDelete: () {
                                    final list = List<EducationEntity>.from(resume.educations)
                                      ..removeAt(i);
                                    _updateResume(resume.copyWith(educations: list));
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
                                  _updateResume(
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
                        ),
                        AppSpacing.v12,

                        // 5. Skills Section
                        AccordionSection(
                          title: AppStrings.skillsAndTools,
                          icon: Icons.auto_awesome_outlined,
                          isOpen: _openSection == 'skills',
                          count: resume.skills.length,
                          onToggle: () => _toggleSection('skills'),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: _skillInputController,
                                      hintText: AppStrings.skillPlaceholder,
                                    ),
                                  ),
                                  AppSpacing.h8,
                                  GradientButton(
                                    width: 70.w,
                                    height: 48.h,
                                    onPressed: () {
                                      final text = _skillInputController.text.trim();
                                      if (text.isNotEmpty && !resume.skills.contains(text)) {
                                        _updateResume(
                                          resume.copyWith(
                                            skills: [...resume.skills, text],
                                          ),
                                        );
                                        _skillInputController.clear();
                                      }
                                    },
                                    text: AppStrings.addSkill,
                                    isGlow: false,
                                  ),
                                ],
                              ),
                              if (resume.skills.isNotEmpty) ...[
                                AppSpacing.v12,
                                Wrap(
                                  spacing: 8.w,
                                  runSpacing: 8.h,
                                  children: resume.skills
                                      .map(
                                        (s) => SkillChip(
                                          label: s,
                                          onDeleted: () {
                                            final updated = List<String>.from(resume.skills)
                                              ..remove(s);
                                            _updateResume(resume.copyWith(skills: updated));
                                          },
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ],
                          ),
                        ),
                        AppSpacing.v12,

                        // 6. Certificates & Licenses Section
                        AccordionSection(
                          title: AppStrings.certificatesAndLicenses,
                          icon: Icons.military_tech_outlined,
                          isOpen: _openSection == 'certificates',
                          count: resume.certificates.length,
                          onToggle: () => _toggleSection('certificates'),
                          child: Column(
                            children: [
                              for (int i = 0; i < resume.certificates.length; i++) ...[
                                _CertificateItemCard(
                                  index: i + 1,
                                  certificate: resume.certificates[i],
                                  onChanged: (updatedCert) {
                                    final list = List<CertificateEntity>.from(resume.certificates);
                                    list[i] = updatedCert;
                                    _updateResume(resume.copyWith(certificates: list));
                                  },
                                  onDelete: () {
                                    final list = List<CertificateEntity>.from(resume.certificates)
                                      ..removeAt(i);
                                    _updateResume(resume.copyWith(certificates: list));
                                  },
                                ),
                                AppSpacing.v10,
                              ],
                              SecondaryButton(
                                onPressed: () {
                                  const uuid = Uuid();
                                  final newCert = CertificateEntity(
                                    id: uuid.v4(),
                                    name: '',
                                    issuer: '',
                                    year: '',
                                  );
                                  _updateResume(
                                    resume.copyWith(
                                      certificates: [...resume.certificates, newCert],
                                    ),
                                  );
                                },
                                text: AppStrings.addCertificate,
                                icon: Icon(Icons.add, size: 16.r, color: AppColors.mutedForeground),
                                backgroundColor: Colors.transparent,
                                borderColor: AppColors.border,
                              ),
                            ],
                          ),
                        ),
                        AppSpacing.v32,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ExperienceItemCard extends StatelessWidget {
  final int index;
  final ExperienceEntity experience;
  final ValueChanged<ExperienceEntity> onChanged;
  final VoidCallback onDelete;

  const _ExperienceItemCard({
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
                icon: Icon(Icons.delete_outline_rounded, size: 18.r, color: AppColors.mutedForeground),
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

class _EducationItemCard extends StatelessWidget {
  final int index;
  final EducationEntity education;
  final ValueChanged<EducationEntity> onChanged;
  final VoidCallback onDelete;

  const _EducationItemCard({
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
                icon: Icon(Icons.delete_outline_rounded, size: 18.r, color: AppColors.mutedForeground),
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

class _CertificateItemCard extends StatelessWidget {
  final int index;
  final CertificateEntity certificate;
  final ValueChanged<CertificateEntity> onChanged;
  final VoidCallback onDelete;

  const _CertificateItemCard({
    required this.index,
    required this.certificate,
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
                icon: Icon(Icons.delete_outline_rounded, size: 18.r, color: AppColors.mutedForeground),
                onPressed: onDelete,
              ),
            ],
          ),
          AppSpacing.v6,
          CustomTextField(
            label: AppStrings.certificateName,
            initialValue: certificate.name,
            onChanged: (v) => onChanged(certificate.copyWith(name: v)),
          ),
          AppSpacing.v8,
          Row(
            children: [
              Expanded(
                child: CustomTextField(
                  label: AppStrings.certificateIssuer,
                  initialValue: certificate.issuer,
                  onChanged: (v) => onChanged(certificate.copyWith(issuer: v)),
                ),
              ),
              AppSpacing.h10,
              Expanded(
                child: CustomTextField(
                  label: AppStrings.certificateYear,
                  initialValue: certificate.year,
                  onChanged: (v) => onChanged(certificate.copyWith(year: v)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
