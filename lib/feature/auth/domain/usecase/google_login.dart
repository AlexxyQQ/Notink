import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/auth/domain/repository/auth_repository.dart';

class GoogleLoginUseCase implements UseCase<UserEntity, void> {
  final IAuthRepository repository;

  GoogleLoginUseCase({required this.repository});

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(void params) async {
    return await repository.googleLogin();
  }
}
