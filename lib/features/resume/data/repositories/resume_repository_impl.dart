import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/exceptions.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/features/resume/data/datasources/resume_local_data_source.dart';
import 'package:resumely/features/resume/data/models/resume_model.dart';
import 'package:resumely/features/resume/domain/entities/resume_entity.dart';
import 'package:resumely/features/resume/domain/repositories/resume_repository.dart';

class ResumeRepositoryImpl implements ResumeRepository {
  final ResumeLocalDataSource localDataSource;

  ResumeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, ResumeEntity>> getActiveResume() async {
    try {
      final model = await localDataSource.getActiveResume();
      return Right(model);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ResumeEntity>>> getAllResumes() async {
    try {
      final list = await localDataSource.getAllResumes();
      return Right(list);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveResume(ResumeEntity resume) async {
    try {
      final model = ResumeModel.fromEntity(resume);
      await localDataSource.saveResume(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteResume(String id) async {
    try {
      await localDataSource.deleteResume(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ExportRecordEntity>>> getExportHistory() async {
    try {
      final list = await localDataSource.getExportHistory();
      return Right(list);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addExportRecord(ExportRecordEntity record) async {
    try {
      final model = ExportRecordModel.fromEntity(record);
      await localDataSource.addExportRecord(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearExportHistory() async {
    try {
      await localDataSource.clearExportHistory();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(message: e.message));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
