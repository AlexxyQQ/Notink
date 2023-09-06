import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/auth/domain/repository/auth_repository.dart';

class LogoutUseCase implements UseCase<void, void> {
  final IAuthRepository repository;

  LogoutUseCase({required this.repository});

  @override
  Future<Either<AppErrorHandler, void>> call(void params) {
    return repository.logout();
  }
}
