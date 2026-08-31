import 'package:flutter/material.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/profile/presentation/widgets/security_tile.dart';

class PrivacyPage extends StatelessWidget {
  static const path = '/privacy';
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'Privacy & security',
      subtitle: 'Account',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SECURITY', style: AppTextStyles.overline),
          AppSpacing.v8,
          CardContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SecurityTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change password',
                  subtitle: 'Last updated 3 months ago',
                  onTap: () {},
                ),
                const Divider(color: AppColors.border, height: 1),
                SecurityTile(
                  icon: Icons.phonelink_lock_rounded,
                  title: 'Two-factor authentication',
                  subtitle: 'Disabled',
                  onTap: () {},
                ),
              ],
            ),
          ),
          AppSpacing.v20,
          Text('DATA & PRIVACY', style: AppTextStyles.overline),
          AppSpacing.v8,
          CardContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SecurityTile(
                  icon: Icons.download_outlined,
                  title: 'Download my data',
                  subtitle: 'Get a copy of your resumes and history',
                  onTap: () {},
                ),
                const Divider(color: AppColors.border, height: 1),
                SecurityTile(
                  icon: Icons.delete_outline_rounded,
                  title: 'Delete account',
                  subtitle: 'Permanently remove your account and all data',
                  isDestructive: true,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
