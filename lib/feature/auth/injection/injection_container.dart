import 'package:notink/core/network/api/api.dart';
import 'package:notink/core/network/hive/hive_queries.dart';
import 'package:notink/feature/auth/data/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:notink/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:notink/feature/auth/domain/repository/auth_repository.dart';
import 'package:notink/feature/auth/domain/usecase/delete_user.dart';
import 'package:notink/feature/auth/domain/usecase/google_login.dart';
import 'package:notink/feature/auth/domain/usecase/login.dart';
import 'package:notink/feature/auth/domain/usecase/logout.dart';
import 'package:notink/feature/auth/domain/usecase/signup.dart';
import 'package:notink/feature/auth/domain/usecase/upload_profile_pic.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_bloc.dart';
import 'package:notink/injection/app_injection_container.dart';

class AuthInjectionContainer {
  void register() {
    get.registerLazySingleton(() => AuthRemoteDataSource(api: get<Api>()));

    get.registerLazySingleton<IAuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: get<AuthRemoteDataSource>(),
      ),
    );

// Use Cases
    get.registerLazySingleton<LoginUseCase>(
      () => LoginUseCase(
        repository: get<IAuthRepository>(),
      ),
    );

    get.registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(
        repository: get<IAuthRepository>(),
      ),
    );

    get.registerLazySingleton<SignupUseCase>(
      () => SignupUseCase(
        repository: get<IAuthRepository>(),
      ),
    );

    get.registerLazySingleton<UploadProfilePicUseCase>(
      () => UploadProfilePicUseCase(
        repository: get<IAuthRepository>(),
        hiveQueries: get<HiveQueries>(),
      ),
    );

    get.registerLazySingleton<DeleteUserUseCase>(
      () => DeleteUserUseCase(
        repository: get<IAuthRepository>(),
        hiveQueries: get<HiveQueries>(),
      ),
    );

    get.registerLazySingleton(
      () => GoogleLoginUseCase(
        repository: get<IAuthRepository>(),
      ),
    );

// Blocs
    get.registerFactory<RemoteAuthBloc>(
      () => RemoteAuthBloc(
        loginUseCase: get<LoginUseCase>(),
        logoutUseCase: get<LogoutUseCase>(),
        uploadProfilePicUseCase: get<UploadProfilePicUseCase>(),
        googleLoginUseCase: get<GoogleLoginUseCase>(),
        signupUseCase: get<SignupUseCase>(),
        deleteUserUseCase: get<DeleteUserUseCase>(),
      ),
    );
  }
}
