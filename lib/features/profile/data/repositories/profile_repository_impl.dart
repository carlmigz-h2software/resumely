import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/features/profile/data/datasources/profile_local_data_source.dart';
import 'package:resumely/features/profile/data/models/notification_preferences_model.dart';
import 'package:resumely/features/profile/domain/entities/faq_item_entity.dart';
import 'package:resumely/features/profile/domain/entities/notification_preferences_entity.dart';
import 'package:resumely/features/profile/domain/entities/plan_entity.dart';
import 'package:resumely/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<PlanEntity>>> getPlans() async {
    try {
      final plans = await localDataSource.getPlans();
      return Right(plans);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load plans: $e'));
    }
  }

  @override
  Future<Either<Failure, List<FaqItemEntity>>> getFaqItems() async {
    try {
      final faqs = await localDataSource.getFaqItems();
      return Right(faqs);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load FAQ items: $e'));
    }
  }

  @override
  Future<Either<Failure, NotificationPreferencesEntity>> getNotificationPreferences() async {
    try {
      final prefs = await localDataSource.getNotificationPreferences();
      return Right(prefs);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load notification preferences: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> saveNotificationPreferences(
    NotificationPreferencesEntity preferences,
  ) async {
    try {
      final model = NotificationPreferencesModel(
        emailTips: preferences.emailTips,
        exportAlerts: preferences.exportAlerts,
        productUpdates: preferences.productUpdates,
      );
      await localDataSource.saveNotificationPreferences(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to save notification preferences: $e'));
    }
  }
}
