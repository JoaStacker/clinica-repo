import 'dart:convert';

import 'package:clinica_front/data/model/credential.dart';
import 'package:clinica_front/data/model/user_model.dart';
import 'package:clinica_front/services/http_service_imp.dart';

abstract class AuthRemoteDatasource {
  Future<UserModel> authLogin(Credential body);
}

class AuthRemoteDatasourceImp extends AuthRemoteDatasource {
  final HttpServiceImp _client = HttpServiceImp();
  String uri = '/api/Login';
  
  @override
  Future<UserModel> authLogin(Credential body) async{
    try {
      final response = await _client.post(uri, body: jsonEncode(body.toJson()));
      final user = UserModel.fromJson(response.body);
      return user;
    } catch (e) {
      return UserModel.empty;
    }
  }

}