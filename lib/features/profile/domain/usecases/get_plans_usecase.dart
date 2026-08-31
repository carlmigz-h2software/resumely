import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/profile/domain/entities/plan_entity.dart';
import 'package:resumely/features/profile/domain/repositories/profile_repository.dart';

class GetPlansUseCase implements UseCase<List<PlanEntity>, NoParams> {
  final ProfileRepository repository;

  GetPlansUseCase(this.repository);

  @override
  Future<Either<Failure, List<PlanEntity>>> call(NoParams params) async {
    return await repository.getPlans();
  }
}
