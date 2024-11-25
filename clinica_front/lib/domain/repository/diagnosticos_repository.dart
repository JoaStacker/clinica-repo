import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:http/http.dart' as http;

abstract class DiagnosticosRepository {
  Future<List<Diagnostico>> getDiagnosticoPrevio(int idPaciente);
  Future<http.Response> saveNuevoDiagnostico(int idPaciente, String enfermedad);
}