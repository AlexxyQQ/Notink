import 'package:notink/feature/auth/domain/entities/user_entity.dart';

abstract class RemoteAuthEvent {
  const RemoteAuthEvent();
}

class RemoteAuthLoginEvent extends RemoteAuthEvent {
  final UserEntity userEntity;

  const RemoteAuthLoginEvent({
    required this.userEntity,
  });
}

class RemoteAuthLogoutEvent extends RemoteAuthEvent {
  const RemoteAuthLogoutEvent();
}

class RemoteAuthSignupEvent extends RemoteAuthEvent {
  final UserEntity userEntity;
  const RemoteAuthSignupEvent({
    required this.userEntity,
  });
}

class RemoteAuthGoogleEvent extends RemoteAuthEvent {
  const RemoteAuthGoogleEvent();
}

class RemoteAuthUploadProfilePicEvent extends RemoteAuthEvent {
  final String path;
  const RemoteAuthUploadProfilePicEvent({
    required this.path,
  });
}

class RemoteAuthDeleteProfileEvent extends RemoteAuthEvent {
  const RemoteAuthDeleteProfileEvent();
}
