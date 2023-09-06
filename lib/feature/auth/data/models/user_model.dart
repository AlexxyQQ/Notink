import 'package:notink/feature/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String username,
    required String email,
    required String password,
    required String profilePic,
    required String type,
    required String token,
  }) : super(
          id: id,
          username: username,
          email: email,
          password: password,
          profilePic: profilePic,
          type: type,
          token: token,
        );

  UserModel.empty()
      : super(
          id: '001',
          username: 'Guest',
          email: 'Guest@Notink.com',
          password: 'Notink@123',
          profilePic: '',
          type: 'guest',
          token: 'notink',
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      profilePic: json['profilePic'] as String,
      type: json['type'] as String,
      token: json['token'] as String,
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePic: map['profilePic'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }
  factory UserModel.fromAPIMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['_id'] as String,
      username: map['username'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      profilePic: map['profilePic'] as String,
      type: map['type'] as String,
      token: map['token'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'email': email,
      'password': password,
      'profilePic': profilePic,
      'type': type,
      'token': token,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      password: entity.password,
      profilePic: entity.profilePic,
      type: entity.type,
      token: entity.token,
    );
  }
  UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      username: model.username,
      email: model.email,
      password: model.password,
      profilePic: model.profilePic,
      type: model.type,
      token: model.token,
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, username: $username, email: $email, password: $password, profilePic: $profilePic, type: $type, token: $token)';
  }
}
