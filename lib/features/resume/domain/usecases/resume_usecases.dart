import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/domain/repositories/resume_repository.dart';

class GetActiveResumeUseCase implements UseCase<ResumeEntity, NoParams> {
  final ResumeRepository repository;

  GetActiveResumeUseCase(this.repository);

  @override
  Future<Either<Failure, ResumeEntity>> call(NoParams params) async {
    return await repository.getActiveResume();
  }
}

class SaveResumeUseCase implements UseCase<void, ResumeEntity> {
  final ResumeRepository repository;

  SaveResumeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ResumeEntity params) async {
    return await repository.saveResume(params);
  }
}

class GetAllResumesUseCase implements UseCase<List<ResumeEntity>, NoParams> {
  final ResumeRepository repository;

  GetAllResumesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ResumeEntity>>> call(NoParams params) async {
    return await repository.getAllResumes();
  }
}

class DeleteResumeUseCase implements UseCase<void, String> {
  final ResumeRepository repository;

  DeleteResumeUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String params) async {
    return await repository.deleteResume(params);
  }
}

class GetExportHistoryUseCase implements UseCase<List<ExportRecordEntity>, NoParams> {
  final ResumeRepository repository;

  GetExportHistoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<ExportRecordEntity>>> call(NoParams params) async {
    return await repository.getExportHistory();
  }
}

class AddExportRecordUseCase implements UseCase<void, ExportRecordEntity> {
  final ResumeRepository repository;

  AddExportRecordUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ExportRecordEntity params) async {
    return await repository.addExportRecord(params);
  }
}
