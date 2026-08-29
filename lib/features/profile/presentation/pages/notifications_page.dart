import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';

class NotificationsPage extends StatefulWidget {
  static const path = '/notifications';
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool _emailTips = true;
  bool _exportAlerts = true;
  bool _productUpdates = false;

  @override
  Widget build(BuildContext context) {
    return SubPageScaffold(
      title: 'Notifications',
      subtitle: 'Account',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('PREFERENCES', style: AppTextStyles.overline),
          AppSpacing.v8,
          CardContainer(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SwitchTile(
                  title: 'Resume improvement tips',
                  subtitle: 'Get AI-driven tips on wording and design',
                  value: _emailTips,
                  onChanged: (v) => setState(() => _emailTips = v),
                ),
                const Divider(color: AppColors.border, height: 1),
                _SwitchTile(
                  title: 'Export & download alerts',
                  subtitle: 'Notifications when your PDF is generated',
                  value: _exportAlerts,
                  onChanged: (v) => setState(() => _exportAlerts = v),
                ),
                const Divider(color: AppColors.border, height: 1),
                _SwitchTile(
                  title: 'Product updates',
                  subtitle: 'Hear about new features and templates',
                  value: _productUpdates,
                  onChanged: (v) => setState(() => _productUpdates = v),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchTile({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.bodyMedium),
                SizedBox(height: 2.h),
                Text(subtitle, style: AppTextStyles.caption),
              ],
            ),
          ),
          Switch(
            value: value,
            activeTrackColor: AppColors.primary,
            activeThumbColor: Colors.white,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
