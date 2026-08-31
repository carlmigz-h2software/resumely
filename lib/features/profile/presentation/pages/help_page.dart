import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/profile/presentation/widgets/help_tile.dart';

class HelpPage extends StatelessWidget {
  static const path = '/help';
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'Help center',
      subtitle: 'Resumely',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FAQ & SUPPORT', style: AppTextStyles.overline),
          AppSpacing.v8,
          CardContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                HelpTile(
                  icon: AppIcons.fileText,
                  title: 'How to export to PDF?',
                  onTap: () => context.push('/help/export-guide'),
                ),
                const Divider(color: AppColors.border, height: 1),
                HelpTile(
                  icon: AppIcons.sparkles,
                  title: 'How does AI enhancement work?',
                  onTap: () => context.push('/help/ai-guide'),
                ),
                const Divider(color: AppColors.border, height: 1),
                HelpTile(
                  icon: Icons.devices_rounded,
                  title: 'Offline editing support',
                  onTap: () => context.push('/help/offline-guide'),
                ),
                const Divider(color: AppColors.border, height: 1),
                HelpTile(
                  icon: AppIcons.messageCircle,
                  title: 'Contact support',
                  onTap: () => context.push('/help/contact-support'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
