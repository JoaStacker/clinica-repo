import 'package:clinica_front/data/model/credential.dart';
import 'package:clinica_front/data/model/user_model.dart';

abstract class AuthRepository{
  Future<UserModel> authLogin(Credential body);
}