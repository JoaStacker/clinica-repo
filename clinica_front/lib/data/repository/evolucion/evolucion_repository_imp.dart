import 'package:clinica_front/data/datasources/evolucion/evolucion_remote_datasource.dart';
import 'package:clinica_front/data/model/evolucion_request.dart';
import 'package:clinica_front/domain/repository/evolucion_repository.dart';
import 'package:http/http.dart' as http;


class EvolucionRepositoryImp extends EvolucionRepository {
  final _evolucionRemoteDatasourceImp = EvolucionRemoteDatasourceImp();

  @override
  Future<http.Response> saveEvolution(EvolutionRequest body, int pacienteId) async {
    final response = await _evolucionRemoteDatasourceImp.saveEvolution(body, pacienteId);
    return response;
  }

}