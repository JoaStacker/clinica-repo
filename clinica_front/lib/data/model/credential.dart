class Credential{
  final String email;
  final String clave;
  Credential(this.email, this.clave);

  Credential.fromJson(Map<String, dynamic> map) :
        email = map['email'],
        clave = map['clave'];

  Map<String, dynamic> toJson() => {
    'email': email,
    'clave': clave
  };
}