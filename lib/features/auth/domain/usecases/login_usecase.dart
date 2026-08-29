import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:resumely/core/errors/failures.dart';
import 'package:resumely/core/usecases/usecase.dart';
import 'package:resumely/features/auth/domain/entities/user_entity.dart';
import 'package:resumely/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [email, password];
}
