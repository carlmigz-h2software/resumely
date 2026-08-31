import 'package:flutter/material.dart';
import 'package:resumely/app/components/card_container.dart';
import 'package:resumely/app/components/sub_page_scaffold.dart';
import 'package:resumely/app/constants/app_colors.dart';
import 'package:resumely/app/constants/app_spacing.dart';
import 'package:resumely/app/constants/app_textstyles.dart';
import 'package:resumely/features/profile/presentation/widgets/preference_switch_tile.dart';

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
                PreferenceSwitchTile(
                  title: 'Resume improvement tips',
                  subtitle: 'Get AI-driven tips on wording and design',
                  value: _emailTips,
                  onChanged: (v) => setState(() => _emailTips = v),
                ),
                const Divider(color: AppColors.border, height: 1),
                PreferenceSwitchTile(
                  title: 'Export & download alerts',
                  subtitle: 'Notifications when your PDF is generated',
                  value: _exportAlerts,
                  onChanged: (v) => setState(() => _exportAlerts = v),
                ),
                const Divider(color: AppColors.border, height: 1),
                PreferenceSwitchTile(
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
