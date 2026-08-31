import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/features/home/data/datasources/home_local_data_source.dart';
import 'package:resumely/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:resumely/features/home/domain/entities/resume_template_entity.dart';
import 'package:resumely/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, HomeDashboardEntity>> getDashboardData() async {
    try {
      final data = await localDataSource.getDashboardData();
      return Right(data);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load dashboard data: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ResumeTemplateEntity>>> getTemplates() async {
    try {
      final templates = await localDataSource.getTemplates();
      return Right(templates);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to load templates: $e'));
    }
  }
}
