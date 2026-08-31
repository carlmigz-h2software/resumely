import 'package:dartz/dartz.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/profile/domain/entities/faq_item_entity.dart';
import 'package:resumely/features/profile/domain/repositories/profile_repository.dart';

class GetFaqItemsUseCase implements UseCase<List<FaqItemEntity>, NoParams> {
  final ProfileRepository repository;

  GetFaqItemsUseCase(this.repository);

  @override
  Future<Either<Failure, List<FaqItemEntity>>> call(NoParams params) async {
    return await repository.getFaqItems();
  }
}
