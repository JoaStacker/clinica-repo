import 'dart:convert';

import 'package:clinica_front/data/model/perfil_usuario.dart';
import 'package:clinica_front/locator.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/model/credential.dart';

class AuthenticationService { 
  final FlutterSecureStorage _flutterSecureStorage = locator<FlutterSecureStorage>();

  PerfilUsuario? get user => _user;
  PerfilUsuario? _user;


  Future<Credential?> _readCredentials() async {
    String? credentials = await _flutterSecureStorage.read(key: 'credentials');
    if (credentials == null) return null;

    return Credential.fromJson(jsonDecode(credentials));
  }

  Future<void> _writeCredentials(Credential credential) async {
    String value = jsonEncode(credential.toJson());
    return _flutterSecureStorage.write(key: 'credentials', value: value);
  }
}