import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/network/hive/hive_queries.dart';
import 'package:notink/core/usecase/usecase.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';
import 'package:notink/feature/auth/domain/repository/auth_repository.dart';

class UploadProfilePicUseCase implements UseCase<void, String> {
  final IAuthRepository repository;
  final HiveQueries hiveQueries;

  UploadProfilePicUseCase({
    required this.repository,
    required this.hiveQueries,
  });

  @override
  Future<Either<AppErrorHandler, UserEntity>> call(String params) async {
    final token = await hiveQueries.getValue(
      boxName: 'users',
      key: 'token',
      defaultValue: '',
    );
    return repository.uploadProfilePic(
      token: token,
      profilePicPath: params,
    );
  }
}
