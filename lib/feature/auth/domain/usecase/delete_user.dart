import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/network/hive/hive_queries.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/auth/domain/repository/auth_repository.dart';

class DeleteUserUseCase implements UseCase<void, void> {
  final IAuthRepository repository;
  final HiveQueries hiveQueries;

  DeleteUserUseCase({
    required this.repository,
    required this.hiveQueries,
  });

  @override
  Future<Either<AppErrorHandler, void>> call(void params) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return repository.deleteUser(token: token);
  }
}
