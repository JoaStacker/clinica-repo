import 'package:clinica_front/data/datasources/auth/auth_remote_datasource.dart';
import 'package:clinica_front/data/model/credential.dart';
import 'package:clinica_front/data/model/user_model.dart';
import 'package:clinica_front/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  final authRemoteDatasourceImp = AuthRemoteDatasourceImp();

  @override
  Future<UserModel> authLogin(Credential body) {
    final user = authRemoteDatasourceImp.authLogin(body);
    return user;
  }
}