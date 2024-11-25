import 'dart:convert';

class UserModel {
  String email;
  String token;
  int medicoId;
  
  UserModel({
    required this.email,
    required this.token,
    required this.medicoId
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'token': token,
      'medicoId': medicoId
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] as String,
      token: map['token'] as String,
      medicoId: map['medicoId'] as int
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  static final empty = UserModel(
      email: '',
      token: '',
      medicoId: 0
  );
}
