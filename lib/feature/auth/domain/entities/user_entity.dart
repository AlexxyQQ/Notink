class UserEntity {
  String id;
  String username;
  String email;
  String password;
  String profilePic;
  String type;
  String token;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.profilePic,
    required this.type,
    required this.token,
  });

  factory UserEntity.empty() {
    return UserEntity(
      id: '001',
      username: 'Guest',
      email: 'Guest@Notink.com',
      password: 'Notink@123',
      profilePic: '',
      type: 'guest',
      token: 'notink',
    );
  }

  UserEntity copyWith({
    String? id,
    String? username,
    String? email,
    String? password,
    String? profilePic,
    String? type,
    String? token,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      profilePic: profilePic ?? this.profilePic,
      type: type ?? this.type,
      token: token ?? this.token,
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

  @override
  String toString() {
    return 'UserEntity(id: $id, username: $username, email: $email, password: $password, profilePic: $profilePic, type: $type, token: $token)';
  }
}
