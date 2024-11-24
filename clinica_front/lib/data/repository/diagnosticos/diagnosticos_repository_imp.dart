import 'package:clinica_front/data/datasources/diagnosticos/diagnosticos_remote_datasource.dart';
import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:clinica_front/domain/repository/diagnosticos_repository.dart';

class DiagnosticosRepositoryImp extends DiagnosticosRepository {
  final _diagnosticosRemoteDatasurce = DiagnosticosRemoteDatasourceImp();

  @override
  Future<List<Diagnostico>> getDiagnosticoPrevio(int idPaciente) async{
    List<Diagnostico> diagnosticos = await _diagnosticosRemoteDatasurce.getDiagnosticoPrevio(idPaciente);
    return diagnosticos;
  }
  
}