import 'package:clinica_front/data/datasources/diagnosticos/diagnosticos_remote_datasource.dart';
import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:clinica_front/domain/repository/diagnosticos_repository.dart';
import 'package:http/http.dart' as http;

class DiagnosticosRepositoryImp extends DiagnosticosRepository {
  final _diagnosticosRemoteDatasurce = DiagnosticosRemoteDatasourceImp();

  @override
  Future<List<Diagnostico>> getDiagnosticoPrevio(int idPaciente) async{
    List<Diagnostico> diagnosticos = await _diagnosticosRemoteDatasurce.getDiagnosticoPrevio(idPaciente);
    return diagnosticos;
  }
  
  @override
  Future<http.Response> saveNuevoDiagnostico(int idPaciente, String enfermedad) async {
    final response = await _diagnosticosRemoteDatasurce.saveNuevoDiagnostico(idPaciente, enfermedad);
    return response;
  }
}