import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/features/profile/domain/entities/faq_item_entity.dart';
import 'package:resumely/features/profile/domain/entities/notification_preferences_entity.dart';
import 'package:resumely/features/profile/domain/entities/plan_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, List<PlanEntity>>> getPlans();
  Future<Either<Failure, List<FaqItemEntity>>> getFaqItems();
  Future<Either<Failure, NotificationPreferencesEntity>> getNotificationPreferences();
  Future<Either<Failure, void>> saveNotificationPreferences(NotificationPreferencesEntity preferences);
}
