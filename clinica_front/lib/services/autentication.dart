import 'dart:convert';

import 'package:clinica_front/data/model/credential.dart';
import 'package:clinica_front/data/model/user_model.dart';
import 'package:clinica_front/data/repository/auth/auth_repository_imp.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationService with NavegationServices { 
  final FlutterSecureStorage _flutterSecureStorage = locator<FlutterSecureStorage>();
  final _authRepositoryImp = AuthRepositoryImp();

  UserModel _user = UserModel.empty;
  UserModel get user => _user;

  Future<String> getToken() async {
    return await _flutterSecureStorage.read(key: 'auth_token') ?? '';
  }

  Future<void> initializeUser() async {
    final token = await getToken();
    if (token.isNotEmpty) {
      try {
        String? userData = await _flutterSecureStorage.read(key: 'userData');
        if (userData != null) _user = UserModel.fromJson(userData);
      } catch (e) {
        _user = UserModel.empty;
        await logout();
      }
    }
  }

  Future<UserModel> login(Credential credential) async {
    // authenticate user using email and password
    _user = await _authRepositoryImp.authLogin(credential);
    // store authentication token
    await _flutterSecureStorage.write(key: 'auth_token', value: _user.token);

    String value = jsonEncode(_user.toMap());
    await _flutterSecureStorage.write(key: 'userData', value: value);

    return _user;
  }

  Future<void> logout() async {
    // delete authentication token
    await _flutterSecureStorage.deleteAll();
    _user = UserModel.empty; 
    navigationReplace(path: '/login');
  }


}

