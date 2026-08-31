import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:resumely/features/home/domain/repositories/home_repository.dart';

class GetHomeDashboardUseCase implements UseCase<HomeDashboardEntity, NoParams> {
  final HomeRepository repository;

  GetHomeDashboardUseCase(this.repository);

  @override
  Future<Either<Failure, HomeDashboardEntity>> call(NoParams params) async {
    return await repository.getDashboardData();
  }
}
