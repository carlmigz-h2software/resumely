import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/profile/domain/entities/notification_preferences_entity.dart';
import 'package:resumely/features/profile/domain/repositories/profile_repository.dart';

class SaveNotificationPreferencesUseCase
    implements UseCase<void, NotificationPreferencesEntity> {
  final ProfileRepository repository;

  SaveNotificationPreferencesUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NotificationPreferencesEntity params) async {
    return await repository.saveNotificationPreferences(params);
  }
}
