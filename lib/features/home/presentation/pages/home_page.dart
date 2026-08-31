import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/section_header.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:resumely/features/home/presentation/widgets/active_resume_card.dart';
import 'package:resumely/features/home/presentation/widgets/ai_suggestion_banner.dart';
import 'package:resumely/features/home/presentation/widgets/home_header.dart';
import 'package:resumely/features/home/presentation/widgets/section_progress_tile.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final userName = authState.user?.name ?? 'Jordan';

        return BlocBuilder<ResumeBloc, ResumeState>(
          builder: (context, resumeState) {
            final activeResume = resumeState.activeResume;
            final completion = activeResume?.completionPercentage ?? 82;
            final resumeTitle = activeResume?.title.isNotEmpty == true
                ? activeResume!.title
                : 'Senior Product Designer';

            return SingleChildScrollView(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSpacing.v8,

                  // 1. Welcome & Create Action Header
                  HomeHeader(
                    userName: userName,
                    onCreateResume: () => context.push('/editor'),
                  ),
                  AppSpacing.v20,

                  // 2. Active Resume Card
                  ActiveResumeCard(
                    title: resumeTitle,
                    completionPercentage: completion,
                    onEdit: () => context.push('/editor'),
                    onPreview: () => context.push('/preview'),
                  ),
                  AppSpacing.v24,

                  // 3. Sections Header
                  const SectionHeader(
                    title: AppStrings.sections,
                    trailingText: '4 ${AppStrings.total}',
                  ),
                  AppSpacing.v12,

                  // 4. Section Progress Items with SVG icons
                  SectionProgressTile(
                    icon: AppIcons.fileUser,
                    title: AppStrings.personalInfo,
                    progress: 1.0,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v8,
                  SectionProgressTile(
                    icon: AppIcons.briefcase,
                    title: AppStrings.workExperience,
                    progress: (activeResume?.experiences.isNotEmpty == true)
                        ? 0.85
                        : 0.4,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v8,
                  SectionProgressTile(
                    icon: AppIcons.graduationCap,
                    title: AppStrings.education,
                    progress: (activeResume?.educations.isNotEmpty == true)
                        ? 1.0
                        : 0.3,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v8,
                  SectionProgressTile(
                    icon: AppIcons.sparkles,
                    title: AppStrings.skillsAndTools,
                    progress: (activeResume?.skills.isNotEmpty == true)
                        ? 0.9
                        : 0.2,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v20,

                  // 5. AI Suggestion Banner
                  AiSuggestionBanner(
                    onApply: () => context.push('/editor'),
                  ),
                  AppSpacing.v16,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
