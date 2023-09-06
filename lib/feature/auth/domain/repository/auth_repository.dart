import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';

abstract class IAuthRepository {
  Future<Either<AppErrorHandler, UserEntity>> login({
    required String email,
    required String password,
  });
  Future<Either<AppErrorHandler, UserEntity>> signup({
    required String email,
    required String password,
    required String username,
  });
  Future<Either<AppErrorHandler, UserEntity>> googleLogin();
  Future<Either<AppErrorHandler, void>> logout();

  Future<Either<AppErrorHandler, UserEntity>> uploadProfilePic({
    required String token,
    required String profilePicPath,
  });

  Future<Either<AppErrorHandler, bool>> deleteUser({
    required String token,
  });
}
