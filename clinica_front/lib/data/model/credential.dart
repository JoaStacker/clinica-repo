
class Credential{

  final String username;
  final String password;

  Credential.fromJson(Map<String, dynamic> map) :
        username = map['username'],
        password = map['password'];

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password
  };
}