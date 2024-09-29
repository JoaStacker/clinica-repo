import 'package:clinica_front/data/datasources/pacientes/pacientes_remote_datasource.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/domain/repository/pacientes_repository.dart';

class PacientesRepositoryImp extends PacientesRepository {
  final pacientesRemoteDatasourceImp = PacientesRemoteDatasourceImp();

  @override
  Future<List<Paciente>> getPaciente() async {
    List<Paciente> pacientes = List.empty(growable: true);
    try{
      pacientes = await pacientesRemoteDatasourceImp.getPaciente();
    }catch (e){
      rethrow;
    }
    return pacientes;
  }
}