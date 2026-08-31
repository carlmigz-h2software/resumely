import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/profile/domain/entities/notification_preferences_entity.dart';
import 'package:resumely/features/profile/domain/repositories/profile_repository.dart';

class GetNotificationPreferencesUseCase
    implements UseCase<NotificationPreferencesEntity, NoParams> {
  final ProfileRepository repository;

  GetNotificationPreferencesUseCase(this.repository);

  @override
  Future<Either<Failure, NotificationPreferencesEntity>> call(NoParams params) async {
    return await repository.getNotificationPreferences();
  }
}
