import 'package:clinica_front/data/model/evolucion_request.dart';
import 'package:clinica_front/data/model/medicamento_api_salud.dart';
import 'package:http/http.dart' as http;

abstract class EvolucionRepository {
  Future<http.Response> saveEvolution(EvolutionRequest body, int pacienteId);
  Future<List<MedicamentoApiSalud>> getMedicamentosApiSalud();
}