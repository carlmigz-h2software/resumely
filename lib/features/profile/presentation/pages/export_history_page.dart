import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/resume/presentation/bloc/resume_bloc.dart';

class ExportHistoryPage extends StatelessWidget {
  static const path = '/export-history';
  const ExportHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResumeBloc, ResumeState>(
      builder: (context, state) {
        final history = state.exportHistory;

        return SubPageScaffold(
          title: 'Export history',
          subtitle: 'Resumely',
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('RECENT EXPORTS', style: AppTextStyles.overline),
              AppSpacing.v8,
              if (history.isEmpty) ...[
                CardContainer(
                  padding: EdgeInsets.symmetric(vertical: 32.h),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.history_rounded, size: 32.r, color: AppColors.mutedForeground),
                        AppSpacing.v8,
                        Text('No exports yet.', style: AppTextStyles.bodyMedium),
                        SizedBox(height: 2.h),
                        Text(
                          'Exported PDFs will show up here.',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                ),
              ] else ...[
                CardContainer(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (int i = 0; i < history.length; i++) ...[
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                          child: Row(
                            children: [
                              Container(
                                width: 36.r,
                                height: 36.r,
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.15),
                                  borderRadius: AppSpacing.borderRadiusSm,
                                ),
                                child: Icon(
                                  Icons.picture_as_pdf_rounded,
                                  size: 18.r,
                                  color: AppColors.primary,
                                ),
                              ),
                              AppSpacing.h12,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      history[i].name,
                                      style: AppTextStyles.bodyMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 2.h),
                                    Text(
                                      'PDF · Just now',
                                      style: AppTextStyles.caption,
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.download_rounded,
                                size: 18.r,
                                color: AppColors.mutedForeground,
                              ),
                            ],
                          ),
                        ),
                        if (i < history.length - 1)
                          const Divider(color: AppColors.border, height: 1),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
