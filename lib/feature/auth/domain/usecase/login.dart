import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/auth/domain/repository/auth_repository.dart';

class LoginUseCase implements UseCase<UserEntity, UserEntity> {
  final IAuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(UserEntity params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}
