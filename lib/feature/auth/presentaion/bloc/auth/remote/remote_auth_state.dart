import 'package:equatable/equatable.dart';
import 'package:notink/core/failure/error_handler.dart';
import 'package:notink/feature/auth/domain/entities/user_entity.dart';

abstract class RemoteAuthState extends Equatable {
  final UserEntity? loggedUser;
  final String? token;
  final AppErrorHandler? error;

  const RemoteAuthState({
    this.loggedUser,
    this.token,
    this.error,
  });

  @override
  List<Object?> get props => [
        loggedUser,
        error,
        token,
      ];
}

class RemoteAuthInitial extends RemoteAuthState {
  const RemoteAuthInitial();
}

class RemoteAuthLoading extends RemoteAuthState {
  const RemoteAuthLoading();
}

class RemoteAuthLoggedIn extends RemoteAuthState {
  const RemoteAuthLoggedIn({
    required UserEntity loggedUser,
  }) : super(
          loggedUser: loggedUser,
        );
}

class RemoteAuthLoggedOut extends RemoteAuthState {
  const RemoteAuthLoggedOut()
      : super(
          loggedUser: null,
        );
}

class RemoteAuthError extends RemoteAuthState {
  const RemoteAuthError({
    required AppErrorHandler error,
  }) : super(
          error: error,
        );
}
