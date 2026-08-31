import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/features/home/domain/entities/home_dashboard_entity.dart';
import 'package:resumely/features/home/domain/entities/resume_template_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeDashboardEntity>> getDashboardData();
  Future<Either<Failure, List<ResumeTemplateEntity>>> getTemplates();
}
