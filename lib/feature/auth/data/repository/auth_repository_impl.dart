import 'package:dartz/dartz.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/data/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';
import 'package:notink/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends IAuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<AppErrorHandler, UserModel>> googleLogin() async {
    try {
      final response = await authRemoteDataSource.google();
      return response.fold((l) {
        return Left(l);
      }, (r) {
        return Right(UserModel.fromMap(r));
      });
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, UserModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await authRemoteDataSource.loginUser(
        email: email,
        password: password,
      );
      return response.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(UserModel.fromMap(r));
        },
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, void>> logout() async {
    try {
      return await authRemoteDataSource.logout();
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, UserModel>> signup({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await authRemoteDataSource.signupUser(
        email: email,
        password: password,
        username: username,
      );
      return response.fold(
        (l) {
          return Left(l);
        },
        (r) {
          return Right(UserModel.fromMap(r));
        },
      );
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, UserModel>> uploadProfilePic({
    required String token,
    required String profilePicPath,
  }) async {
    try {
      final response = await authRemoteDataSource.uploadProfilePic(
        token: token,
        profilePicPath: profilePicPath,
      );
      return response;
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  @override
  Future<Either<AppErrorHandler, bool>> deleteUser({
    required String token,
  }) async {
    return await authRemoteDataSource.deleteUser(token: token);
  }
}
