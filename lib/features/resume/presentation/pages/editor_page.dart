import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/certificates_section.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/editor_header.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/education_section.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/experience_section.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/objective_section.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/personal_info_section.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/profile_photo_card.dart';
import 'package:resumely/features/resume/presentation/widgets/editor/skills_section.dart';

class EditorPage extends StatefulWidget {
  static const path = '/editor';
  const EditorPage({super.key});

  @override
  State<EditorPage> createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  String _openSection = 'personal';

  void _toggleSection(String id) {
    setState(() {
      _openSection = _openSection == id ? '' : id;
    });
  }

  void _updateResume(ResumeEntity updated) {
    context.read<ResumeBloc>().add(ResumeUpdated(updated));
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
                // 1. Sticky Header
                EditorHeader(
                  title: resume.title,
                  isSaving: isSaving,
                  isSaved: isSaved,
                  onBack: () => context.pop(),
                  onPreview: () => context.push('/preview'),
                ),

                // 2. Editor Sections Scrollable List
                Expanded(
                  child: SingleChildScrollView(
                    padding: AppSpacing.screenPadding,
                    child: Column(
                      children: [
                        // Profile Photo
                        const ProfilePhotoCard(),
                        AppSpacing.v12,

                        // Personal Info
                        PersonalInfoSection(
                          resume: resume,
                          isOpen: _openSection == 'personal',
                          onToggle: () => _toggleSection('personal'),
                          onChanged: _updateResume,
                        ),
                        AppSpacing.v12,

                        // Career Objective
                        ObjectiveSection(
                          resume: resume,
                          isOpen: _openSection == 'objective',
                          onToggle: () => _toggleSection('objective'),
                          onChanged: _updateResume,
                        ),
                        AppSpacing.v12,

                        // Work Experience
                        ExperienceSection(
                          resume: resume,
                          isOpen: _openSection == 'experience',
                          onToggle: () => _toggleSection('experience'),
                          onChanged: _updateResume,
                        ),
                        AppSpacing.v12,

                        // Education
                        EducationSection(
                          resume: resume,
                          isOpen: _openSection == 'education',
                          onToggle: () => _toggleSection('education'),
                          onChanged: _updateResume,
                        ),
                        AppSpacing.v12,

                        // Skills & Tools
                        SkillsSection(
                          resume: resume,
                          isOpen: _openSection == 'skills',
                          onToggle: () => _toggleSection('skills'),
                          onChanged: _updateResume,
                        ),
                        AppSpacing.v12,

                        // Certificates & Licenses
                        CertificatesSection(
                          resume: resume,
                          isOpen: _openSection == 'certificates',
                          onToggle: () => _toggleSection('certificates'),
                          onChanged: _updateResume,
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
