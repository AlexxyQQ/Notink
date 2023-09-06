import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notink/feature/auth/domain/usecase/delete_user.dart';
import 'package:notink/feature/auth/domain/usecase/google_login.dart';
import 'package:notink/feature/auth/domain/usecase/login.dart';
import 'package:notink/feature/auth/domain/usecase/logout.dart';
import 'package:notink/feature/auth/domain/usecase/signup.dart';
import 'package:notink/feature/auth/domain/usecase/upload_profile_pic.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_even.dart';
import 'package:notink/feature/auth/presentaion/bloc/auth/remote/remote_auth_state.dart';

class RemoteAuthBloc extends Bloc<RemoteAuthEvent, RemoteAuthState> {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final UploadProfilePicUseCase uploadProfilePicUseCase;
  final GoogleLoginUseCase googleLoginUseCase;
  final SignupUseCase signupUseCase;
  final DeleteUserUseCase deleteUserUseCase;

  RemoteAuthBloc({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.uploadProfilePicUseCase,
    required this.googleLoginUseCase,
    required this.signupUseCase,
    required this.deleteUserUseCase,
  }) : super(const RemoteAuthInitial()) {
    on<RemoteAuthLoginEvent>(login);
    on<RemoteAuthLogoutEvent>(logout);
    on<RemoteAuthSignupEvent>(signup);
    on<RemoteAuthGoogleEvent>(googleLogin);
    on<RemoteAuthUploadProfilePicEvent>(uploadProfilePic);
  }

  Future<void> login(
      RemoteAuthLoginEvent event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());

    final data = await loginUseCase.call(event.userEntity);

    data.fold(
      (error) => emit(RemoteAuthError(error: error)),
      (user) => emit(RemoteAuthLoggedIn(loggedUser: user)),
    );
  }

  Future<void> logout(
      RemoteAuthLogoutEvent event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());

    final data = await logoutUseCase(null);

    data.fold(
      (error) => emit(RemoteAuthError(error: error)),
      (_) => emit(const RemoteAuthLoggedOut()),
    );
  }

  Future<void> signup(
      RemoteAuthSignupEvent event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());

    final data = await signupUseCase(event.userEntity);

    data.fold(
      (error) => emit(RemoteAuthError(error: error)),
      (user) => emit(RemoteAuthLoggedIn(loggedUser: user)),
    );
  }

  Future<void> googleLogin(
      RemoteAuthGoogleEvent event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());

    final data = await googleLoginUseCase(null);

    data.fold(
      (error) => emit(RemoteAuthError(error: error)),
      (user) => emit(RemoteAuthLoggedIn(loggedUser: user)),
    );
  }

  Future<void> uploadProfilePic(RemoteAuthUploadProfilePicEvent event,
      Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());

    final data = await uploadProfilePicUseCase(event.path);

    data.fold(
      (error) => emit(RemoteAuthError(error: error)),
      (user) => emit(RemoteAuthLoggedIn(loggedUser: user)),
    );
  }

  Future<void> deleteUser(
      RemoteAuthDeleteProfileEvent event, Emitter<RemoteAuthState> emit) async {
    emit(const RemoteAuthLoading());

    final data = await deleteUserUseCase(null);

    data.fold(
      (error) => emit(RemoteAuthError(error: error)),
      (user) => emit(const RemoteAuthLoggedOut()),
    );
  }
}
