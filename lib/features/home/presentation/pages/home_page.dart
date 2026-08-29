import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/circular_progress_badge.dart';
import 'package:resumely/app/components/gradient_button.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        final userName = authState.user?.name ?? 'Jordan';
        final firstName = userName.split(' ').first;

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
                  // Top Welcome & Create (+) Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.welcomeBack,
                            style: AppTextStyles.caption,
                          ),
                          SizedBox(height: 2.h),
                          Text('$firstName 👋', style: AppTextStyles.h2),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => context.push('/editor'),
                        child: Container(
                          width: 44.r,
                          height: 44.r,
                          decoration: const BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                            boxShadow: AppColors.primaryGlow,
                          ),
                          child: Icon(
                            Icons.add_rounded,
                            size: 22.r,
                            color: AppColors.primaryForeground,
                          ),
                        ),
                      ),
                    ],
                  ),
                  AppSpacing.v20,

                  // Active Resume Card
                  CardContainer(
                    isGradient: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.currentResume.toUpperCase(),
                                    style: AppTextStyles.overline.copyWith(
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(resumeTitle, style: AppTextStyles.h3),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Updated recently',
                                    style: AppTextStyles.caption,
                                  ),
                                ],
                              ),
                            ),
                            CircularProgressBadge(
                              percentage: completion.toDouble(),
                              size: 54,
                            ),
                          ],
                        ),
                        AppSpacing.v16,
                        Row(
                          children: [
                            Expanded(
                              child: GradientButton(
                                onPressed: () => context.push('/editor'),
                                text: AppStrings.continueEditing,
                                height: 42.h,
                                isGlow: false,
                              ),
                            ),
                            AppSpacing.h8,
                            Container(
                              width: 42.h,
                              height: 42.h,
                              decoration: BoxDecoration(
                                color: AppColors.secondary,
                                borderRadius: AppSpacing.borderRadiusMd,
                              ),
                              child: IconButton(
                                icon: Icon(
                                  Icons.download_rounded,
                                  size: 18.r,
                                  color: AppColors.foreground,
                                ),
                                onPressed: () => context.push('/preview'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  AppSpacing.v24,

                  // Sections Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.sections, style: AppTextStyles.h4),
                      Text(
                        '4 ${AppStrings.total}',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                  AppSpacing.v12,

                  // Section items
                  _SectionProgressItem(
                    icon: Icons.person_outline_rounded,
                    title: AppStrings.personalInfo,
                    progress: 1.0,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v8,
                  _SectionProgressItem(
                    icon: Icons.work_outline_rounded,
                    title: AppStrings.workExperience,
                    progress: (activeResume?.experiences.isNotEmpty == true)
                        ? 0.85
                        : 0.4,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v8,
                  _SectionProgressItem(
                    icon: Icons.school_outlined,
                    title: AppStrings.education,
                    progress: (activeResume?.educations.isNotEmpty == true)
                        ? 1.0
                        : 0.3,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v8,
                  _SectionProgressItem(
                    icon: Icons.auto_awesome_outlined,
                    title: AppStrings.skillsAndTools,
                    progress: (activeResume?.skills.isNotEmpty == true)
                        ? 0.9
                        : 0.2,
                    onTap: () => context.push('/editor'),
                  ),
                  AppSpacing.v20,

                  // AI Suggestion Banner
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: AppSpacing.borderRadiusLg,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 36.r,
                          height: 36.r,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: AppSpacing.borderRadiusSm,
                          ),
                          child: Icon(
                            Icons.auto_awesome,
                            size: 18.r,
                            color: AppColors.primaryForeground,
                          ),
                        ),
                        AppSpacing.h12,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.aiSuggestion,
                                style: AppTextStyles.h4,
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                AppStrings.aiSuggestionText,
                                style: AppTextStyles.caption.copyWith(
                                  height: 1.4,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              GestureDetector(
                                onTap: () => context.push('/editor'),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      AppStrings.applySuggestion,
                                      style: AppTextStyles.caption.copyWith(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Icon(
                                      Icons.chevron_right_rounded,
                                      size: 14.r,
                                      color: AppColors.primary,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _SectionProgressItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final double progress;
  final VoidCallback onTap;

  const _SectionProgressItem({
    required this.icon,
    required this.title,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      onTap: onTap,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 38.r,
            height: 38.r,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: AppSpacing.borderRadiusSm,
            ),
            child: Icon(icon, size: 18.r, color: AppColors.primary),
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4.r),
                  child: Container(
                    height: 4.h,
                    width: double.infinity,
                    color: AppColors.muted,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: AppColors.primaryGradient,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSpacing.h12,
          Icon(
            Icons.chevron_right_rounded,
            size: 20.r,
            color: AppColors.mutedForeground,
          ),
        ],
      ),
    );
  }
}

class _TemplateCard extends StatelessWidget {
  final String title;
  final bool isSelected;

  const _TemplateCard({required this.title, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.w,
      margin: EdgeInsets.only(right: 12.w),
      child: Column(
        children: [
          Container(
            height: 130.h,
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: AppColors.surfaceElevated,
              borderRadius: AppSpacing.borderRadiusMd,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.border,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 6.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: AppColors.foreground.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 4.h,
                  width: 75.w,
                  decoration: BoxDecoration(
                    color: AppColors.mutedForeground.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 4.h),
                Container(
                  height: 4.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    color: AppColors.mutedForeground.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Container(
                      height: 4.h,
                      width: 24.w,
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Container(
                      height: 4.h,
                      width: 12.w,
                      decoration: BoxDecoration(
                        color: AppColors.mutedForeground.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            title,
            style: AppTextStyles.caption.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
