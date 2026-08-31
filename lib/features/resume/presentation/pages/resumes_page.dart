import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/app_icon_button.dart';
import 'package:resumely/app/components/empty_state_widget.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';
import 'package:resumely/features/resume/presentation/widgets/resumes/create_resume_dialog.dart';
import 'package:resumely/features/resume/presentation/widgets/resumes/resume_list_item.dart';

class ResumesPage extends StatelessWidget {
  const ResumesPage({super.key});

  void _showCreateDialog(BuildContext context) {
    CreateResumeDialog.show(
      context,
      onCreated: (title) {
        context.read<ResumeBloc>().add(ResumeCreated(title: title));
        context.push('/editor');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResumeBloc, ResumeState>(
      builder: (context, state) {
        final resumes = state.resumes;

        return SingleChildScrollView(
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.v8,
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.myResumes,
                    style: AppTextStyles.h2,
                  ),
                  AppIconButton(
                    icon: Icons.add_rounded,
                    size: 40.r,
                    iconSize: 20.r,
                    color: AppColors.primaryForeground,
                    gradient: AppColors.primaryGradient,
                    boxShadow: AppColors.primaryGlow,
                    onTap: () => _showCreateDialog(context),
                    tooltip: 'Create Resume',
                  ),
                ],
              ),
              AppSpacing.v20,

              // List of resumes or empty state
              if (resumes.isEmpty) ...[
                EmptyStateWidget(
                  icon: AppIcons.fileText,
                  title: 'No resumes found',
                  subtitle: 'Tap the + button to create your first standout resume.',
                  actionText: 'Create resume',
                  onAction: () => _showCreateDialog(context),
                ),
              ] else ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: resumes.length,
                  separatorBuilder: (_, _) => AppSpacing.v10,
                  itemBuilder: (context, index) {
                    final resume = resumes[index];
                    return ResumeListItem(
                      resume: resume,
                      onTap: () {
                        context.read<ResumeBloc>().add(ResumeUpdated(resume));
                        context.push('/editor');
                      },
                      onPreview: () {
                        context.read<ResumeBloc>().add(ResumeUpdated(resume));
                        context.push('/preview');
                      },
                      onDelete: () {
                        context.read<ResumeBloc>().add(ResumeDeleted(resume.id));
                      },
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
