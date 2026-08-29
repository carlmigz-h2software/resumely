import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_strings.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';

class ResumesPage extends StatelessWidget {
  const ResumesPage({super.key});

  void _showCreateDialog(BuildContext context) {
    final controller = TextEditingController(text: 'New Resume');
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusLg),
        title: Text('Create Resume', style: AppTextStyles.h4),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: AppTextStyles.input,
          decoration: const InputDecoration(labelText: 'Resume Title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text('Cancel', style: AppTextStyles.bodySmall),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.primaryForeground,
            ),
            onPressed: () {
              final title = controller.text.trim();
              if (title.isNotEmpty) {
                context.read<ResumeBloc>().add(ResumeCreated(title: title));
                Navigator.pop(ctx);
                context.push('/editor');
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
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
                  GestureDetector(
                    onTap: () => _showCreateDialog(context),
                    child: Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: const BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        shape: BoxShape.circle,
                        boxShadow: AppColors.primaryGlow,
                      ),
                      child: Icon(
                        Icons.add_rounded,
                        size: 20.r,
                        color: AppColors.primaryForeground,
                      ),
                    ),
                  ),
                ],
              ),
              AppSpacing.v20,

              // List of resumes
              if (resumes.isEmpty) ...[
                Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40.h),
                    child: Text(
                      'No resumes found. Tap + to create one!',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.mutedForeground,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: resumes.length,
                  separatorBuilder: (_, _) => AppSpacing.v10,
                  itemBuilder: (context, index) {
                    final resume = resumes[index];
                    return _ResumeListItem(
                      resume: resume,
                      onTap: () {
                        context.read<ResumeBloc>().add(ResumeUpdated(resume));
                        context.push('/editor');
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

class _ResumeListItem extends StatelessWidget {
  final ResumeEntity resume;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _ResumeListItem({
    required this.resume,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      onTap: onTap,
      padding: EdgeInsets.all(14.r),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 48.h,
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: AppSpacing.borderRadiusSm,
              border: Border.all(color: AppColors.border, width: 1),
            ),
            child: Icon(
              Icons.description_outlined,
              size: 20.r,
              color: AppColors.primary,
            ),
          ),
          AppSpacing.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  resume.title.isNotEmpty ? resume.title : 'Untitled Resume',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(999.r),
                      ),
                      child: Text(
                        resume.tag,
                        style: AppTextStyles.overline.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    AppSpacing.h8,
                    Text(
                      '${resume.completionPercentage}% complete',
                      style: AppTextStyles.caption,
                    ),
                  ],
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(
              Icons.more_vert_rounded,
              color: AppColors.mutedForeground,
              size: 20.r,
            ),
            color: AppColors.surfaceElevated,
            shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
            onSelected: (val) {
              if (val == 'edit') {
                onTap();
              } else if (val == 'preview') {
                context.push('/preview');
              } else if (val == 'delete') {
                onDelete();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'edit', child: Text('Edit')),
              const PopupMenuItem(value: 'preview', child: Text('Preview / Export')),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: AppColors.destructive)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
