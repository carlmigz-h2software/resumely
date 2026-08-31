import 'package:equatable/equatable.dart';

class NotificationPreferencesEntity extends Equatable {
  final bool emailTips;
  final bool exportAlerts;
  final bool productUpdates;

  const NotificationPreferencesEntity({
    this.emailTips = true,
    this.exportAlerts = true,
    this.productUpdates = false,
  });

  NotificationPreferencesEntity copyWith({
    bool? emailTips,
    bool? exportAlerts,
    bool? productUpdates,
  }) {
    return NotificationPreferencesEntity(
      emailTips: emailTips ?? this.emailTips,
      exportAlerts: exportAlerts ?? this.exportAlerts,
      productUpdates: productUpdates ?? this.productUpdates,
    );
  }

  @override
  List<Object?> get props => [emailTips, exportAlerts, productUpdates];
}
