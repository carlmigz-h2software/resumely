import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';

abstract class ResumeRepository {
  Future<Either<Failure, ResumeEntity>> getActiveResume();
  Future<Either<Failure, List<ResumeEntity>>> getAllResumes();
  Future<Either<Failure, void>> saveResume(ResumeEntity resume);
  Future<Either<Failure, void>> deleteResume(String id);
  Future<Either<Failure, List<ExportRecordEntity>>> getExportHistory();
  Future<Either<Failure, void>> addExportRecord(ExportRecordEntity record);
  Future<Either<Failure, void>> clearExportHistory();
}
