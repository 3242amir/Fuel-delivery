class User {
  final String name, email, password, type, token;
  final String? uid, imgUrl;

  const User({
    required this.name,
    required this.email,
    required this.password,
    required this.type,
    this.imgUrl,
    required this.token,
    this.uid,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          password == other.password &&
          type == other.type &&
          imgUrl == other.imgUrl &&
          token == other.token &&
          uid == other.uid);

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      type.hashCode ^
      imgUrl.hashCode ^
      token.hashCode ^
      uid.hashCode;

  @override
  String toString() {
    return 'User{ name: $name, email: $email, password: $password, type: $type, imgUrl: $imgUrl, token: $token, uid: $uid,}';
  }

  User copyWith({
    String? name,
    String? email,
    String? password,
    String? type,
    String? imgUrl,
    String? token,
    String? uid,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      type: type ?? this.type,
      imgUrl: imgUrl ?? this.imgUrl,
      token: token ?? this.token,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'type': type,
      'imgUrl': imgUrl,
      'token': token,
      'uid': uid,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      type: map['type'] as String,
      imgUrl: map['imgUrl'] as String,
      token: map['token'] as String,
      uid: map['uid'] as String,
    );
  }
}
