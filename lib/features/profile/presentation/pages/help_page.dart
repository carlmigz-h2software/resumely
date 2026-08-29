import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

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
                _HelpTile(
                  icon: Icons.article_outlined,
                  title: 'How to export to PDF?',
                  onTap: () {},
                ),
                const Divider(color: AppColors.border, height: 1),
                _HelpTile(
                  icon: Icons.auto_awesome_outlined,
                  title: 'How does AI enhancement work?',
                  onTap: () {},
                ),
                const Divider(color: AppColors.border, height: 1),
                _HelpTile(
                  icon: Icons.devices_rounded,
                  title: 'Offline editing support',
                  onTap: () {},
                ),
                const Divider(color: AppColors.border, height: 1),
                _HelpTile(
                  icon: Icons.chat_bubble_outline_rounded,
                  title: 'Contact support',
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

class _HelpTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HelpTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(icon, size: 18.r, color: AppColors.mutedForeground),
            AppSpacing.h12,
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.bodyMedium,
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
