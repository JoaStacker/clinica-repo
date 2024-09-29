import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/model/paciente_request.dart';
import 'package:http/http.dart' as http;

abstract class PacientesRepository{
  Future<List<Paciente>> getPaciente();
  Future<http.Response> savePaciente(PacienteRequest body);
}