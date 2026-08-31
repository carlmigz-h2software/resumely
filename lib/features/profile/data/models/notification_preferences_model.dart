import 'package:resumely/features/profile/domain/entities/notification_preferences_entity.dart';

class NotificationPreferencesModel extends NotificationPreferencesEntity {
  const NotificationPreferencesModel({
    super.emailTips = true,
    super.exportAlerts = true,
    super.productUpdates = false,
  });

  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) {
    return NotificationPreferencesModel(
      emailTips: json['emailTips'] as bool? ?? true,
      exportAlerts: json['exportAlerts'] as bool? ?? true,
      productUpdates: json['productUpdates'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emailTips': emailTips,
      'exportAlerts': exportAlerts,
      'productUpdates': productUpdates,
    };
  }
}
