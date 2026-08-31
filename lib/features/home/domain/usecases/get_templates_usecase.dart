import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/home/domain/entities/resume_template_entity.dart';
import 'package:resumely/features/home/domain/repositories/home_repository.dart';

class GetTemplatesUseCase implements UseCase<List<ResumeTemplateEntity>, NoParams> {
  final HomeRepository repository;

  GetTemplatesUseCase(this.repository);

  @override
  Future<Either<Failure, List<ResumeTemplateEntity>>> call(NoParams params) async {
    return await repository.getTemplates();
  }
}
