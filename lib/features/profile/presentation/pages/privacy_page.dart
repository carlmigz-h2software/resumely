import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

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
                _SecurityTile(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change password',
                  subtitle: 'Last updated 3 months ago',
                  onTap: () {},
                ),
                const Divider(color: AppColors.border, height: 1),
                _SecurityTile(
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
                _SecurityTile(
                  icon: Icons.download_outlined,
                  title: 'Download my data',
                  subtitle: 'Get a copy of your resumes and history',
                  onTap: () {},
                ),
                const Divider(color: AppColors.border, height: 1),
                _SecurityTile(
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

class _SecurityTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SecurityTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18.r,
              color: isDestructive ? AppColors.destructive : AppColors.mutedForeground,
            ),
            AppSpacing.h12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDestructive ? AppColors.destructive : AppColors.foreground,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(subtitle, style: AppTextStyles.caption),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.r,
              color: AppColors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}
