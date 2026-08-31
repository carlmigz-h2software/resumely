import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/empty_state_widget.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/profile/presentation/widgets/export_record_tile.dart';
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
                const CardContainer(
                  padding: EdgeInsets.zero,
                  child: EmptyStateWidget(
                    icon: Icons.history_rounded,
                    title: 'No exports yet.',
                    subtitle: 'Exported PDFs will show up here.',
                  ),
                ),
              ] else ...[
                CardContainer(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      for (int i = 0; i < history.length; i++) ...[
                        ExportRecordTile(
                          name: history[i].name,
                          format: history[i].format,
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
