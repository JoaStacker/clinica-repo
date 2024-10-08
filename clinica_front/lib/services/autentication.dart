import 'package:clinica_front/data/model/credential.dart';
import 'package:clinica_front/data/model/perfil_usuario.dart';
import 'package:clinica_front/data/model/user_model.dart';
import 'package:clinica_front/data/repository/auth/auth_repository_imp.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService with NavegationServices{ 
  final FlutterSecureStorage _flutterSecureStorage = locator<FlutterSecureStorage>();
  final _authRepositoryImp = AuthRepositoryImp();

  PerfilUsuario? get user => _user;
  PerfilUsuario? _user;

  Future<String> getToken() async {
    return await _flutterSecureStorage.read(key: 'auth_token') ?? '';
  }

  Future<UserModel> login(Credential credential) async {
    // authenticate user using email and password
    final user = await _authRepositoryImp.authLogin(credential);
    // store authentication token
    await _flutterSecureStorage.write(key: 'auth_token', value: user.token);
    return user;
  }

  Future<void> logout() async {
    // delete authentication token
    await _flutterSecureStorage.delete(key: 'auth_token');
    navigatorPush('/login');
  }

  Future<String> isAuthenticated() async {
    // check if authentication token exists
    return await _flutterSecureStorage.read(key: 'auth_token') ?? '';
  }
}