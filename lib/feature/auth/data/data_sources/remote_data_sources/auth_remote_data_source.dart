import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notink/config/constants/api_endpoints.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/core/network/api/api.dart';
import 'package:notink/core/network/hive/hive_queries.dart';
import 'package:notink/feature/auth/data/models/user_model.dart';

class AuthRemoteDataSource {
  final Api api;

  AuthRemoteDataSource({
    required this.api,
  });

  Future<Either<AppErrorHandler, Map<String, dynamic>>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.loginRoute,
        data: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        Map<String, dynamic> userData = responseApi.data['user'];
        String token = responseApi.data['token'];
        userData['token'] = token;

        // Replace 'your_received_token_here' with the token received after successful login.
        return Right(userData);
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      } else {
        return Left(
          AppErrorHandler(
            message: 'An unexpected error occurred.',
            status: false,
          ),
        );
      }
    }
  }

  Future<Either<AppErrorHandler, Map<String, dynamic>>> signupUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.signupRoute,
        data: jsonEncode({
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": password,
          "type": "manual",
        }),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);
      if (responseApi.success) {
        Map<String, dynamic> userData = responseApi.data;
        userData['token'] = '';
        return Right(userData);
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      } else {
        return Left(
          AppErrorHandler(
            message: "Network error occurred.",
            status: false,
          ),
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: 'An unexpected error occurred.',
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, void>> logout() async {
    try {
      await GetIt.instance<HiveQueries>().deleteValue(
        boxName: 'users',
        key: 'token',
      );
      return const Right(null);
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, Map<String, dynamic>>> google() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final user = await googleSignIn.signIn();
    try {
      if (user != null) {
        // User signup
        final response = await api.sendRequest.post(
          ApiEndpoints.signupRoute,
          data: jsonEncode({
            "username": user.displayName.toString().toLowerCase(),
            "email": user.email,
            "password": user.id,
            "confirmPassword": user.id,
            "profilePic": user.photoUrl,
            "type": "google",
          }),
        );

        ApiResponse responseApi = ApiResponse.fromResponse(response);
        if (responseApi.success) {
          // Login user
          var loggedUser =
              await loginUser(email: user.email, password: user.id);

          return loggedUser;
        } else {
          return Left(
            AppErrorHandler(
              message: responseApi.message.toString(),
              status: false,
            ),
          );
        }
      } else {
        return Left(
          AppErrorHandler(
            message: 'Google sign in failed.',
            status: false,
          ),
        );
      }
    } on DioError catch (e) {
      if (e.response != null) {
        var responseApi = ApiResponse.fromResponse(e.response!);
        if (responseApi.message.toString() ==
                'User with same USERNAME already exists!' ||
            responseApi.message.toString() ==
                'User with same EMAIL already exists!') {
          //
          if (user != null) {
            // Login user
            var loggedUser =
                await loginUser(email: user.email, password: user.id);

            return loggedUser;
          } else {
            return Left(
              AppErrorHandler(
                message: 'Google sign in failed.',
                status: false,
              ),
            );
          }
        } else {
          return Left(
            AppErrorHandler(
              message: responseApi.message.toString(),
              status: false,
            ),
          );
        }
      } else {
        return Left(
          AppErrorHandler(
            message: 'An unexpected error occurred.',
            status: false,
          ),
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: 'An unexpected error occurred.',
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, UserModel>> uploadProfilePic({
    required String token,
    required String profilePicPath,
  }) async {
    try {
      final profilePicformData = FormData.fromMap({
        'profilePic': await MultipartFile.fromFile(profilePicPath),
      });
      final response = await api.sendRequest.post(
        ApiEndpoints.uploadProfilePicRoute,
        data: profilePicformData,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        Map<String, dynamic> userData = responseApi.data;
        userData['token'] = token;
        return Right(UserModel.fromMap(userData));
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }

  Future<Either<AppErrorHandler, bool>> deleteUser({
    required String token,
  }) async {
    try {
      final response = await api.sendRequest.post(
        ApiEndpoints.deleteUserRoute,
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );

      ApiResponse responseApi = ApiResponse.fromResponse(response);

      if (responseApi.success) {
        return const Right(true);
      } else {
        return Left(
          AppErrorHandler(
            message: responseApi.message.toString(),
            status: false,
          ),
        );
      }
    } catch (e) {
      return Left(
        AppErrorHandler(
          message: e.toString(),
          status: false,
        ),
      );
    }
  }
}
