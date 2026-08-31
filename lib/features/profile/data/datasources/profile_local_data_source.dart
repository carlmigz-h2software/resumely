import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:resumely/app/constants/app_icons.dart';
import 'package:resumely/features/profile/data/models/faq_item_model.dart';
import 'package:resumely/features/profile/data/models/notification_preferences_model.dart';
import 'package:resumely/features/profile/data/models/plan_model.dart';

abstract class ProfileLocalDataSource {
  Future<List<PlanModel>> getPlans();
  Future<List<FaqItemModel>> getFaqItems();
  Future<NotificationPreferencesModel> getNotificationPreferences();
  Future<void> saveNotificationPreferences(NotificationPreferencesModel preferences);
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final SharedPreferences sharedPreferences;

  static const String _notifPrefKey = 'notification_preferences_key';

  ProfileLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PlanModel>> getPlans() async {
    return const [
      PlanModel(
        id: 'free',
        name: 'Free',
        price: '\$0',
        period: '/mo',
        features: [
          '1 resume',
          'Basic templates',
          'PDF export',
        ],
        isCurrent: true,
        isPopular: false,
      ),
      PlanModel(
        id: 'pro',
        name: 'Pro',
        price: '\$8',
        period: '/mo',
        features: [
          'Unlimited resumes',
          'Premium templates',
          'AI rewrites',
          'Priority support',
        ],
        isCurrent: false,
        isPopular: true,
      ),
      PlanModel(
        id: 'team',
        name: 'Team',
        price: '\$24',
        period: '/mo',
        features: [
          'Everything in Pro',
          '5 seats',
          'Shared templates',
          'SSO',
        ],
        isCurrent: false,
        isPopular: false,
      ),
    ];
  }

  @override
  Future<List<FaqItemModel>> getFaqItems() async {
    return const [
      FaqItemModel(
        id: 'faq_export',
        title: 'How to export to PDF?',
        icon: AppIcons.fileText,
        answer: 'Tap the preview button at the top of the editor and select Export PDF.',
      ),
      FaqItemModel(
        id: 'faq_ai',
        title: 'How does AI enhancement work?',
        icon: AppIcons.sparkles,
        answer: 'Our AI analyzes your experience bullets and suggests impactful metrics and action verbs.',
      ),
      FaqItemModel(
        id: 'faq_offline',
        title: 'Offline editing support',
        icon: Icons.devices_rounded,
        answer: 'All changes are stored locally in Hive and sync automatically when connected.',
      ),
      FaqItemModel(
        id: 'faq_support',
        title: 'Contact support',
        icon: AppIcons.messageCircle,
        answer: 'Reach out to support@resumely.app for help.',
      ),
    ];
  }

  @override
  Future<NotificationPreferencesModel> getNotificationPreferences() async {
    final raw = sharedPreferences.getString(_notifPrefKey);
    if (raw != null) {
      try {
        final map = jsonDecode(raw) as Map<String, dynamic>;
        return NotificationPreferencesModel.fromJson(map);
      } catch (_) {
        return const NotificationPreferencesModel();
      }
    }
    return const NotificationPreferencesModel();
  }

  @override
  Future<void> saveNotificationPreferences(NotificationPreferencesModel preferences) async {
    await sharedPreferences.setString(
      _notifPrefKey,
      jsonEncode(preferences.toJson()),
    );
  }
}
