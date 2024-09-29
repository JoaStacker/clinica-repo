import 'dart:convert';

import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/services/http_service_imp.dart';
import 'package:http/http.dart' as http;

sealed class PacientesRemoteDatasource {
  Future<List<Paciente>> getPaciente();
}

class PacientesRemoteDatasourceImp extends PacientesRemoteDatasource {
  final HttpServiceImp _client = HttpServiceImp();
  
  @override
  Future<List<Paciente>> getPaciente() async {
    try {
      http.Response response = await _client.get('/api/Paciente');
      List<Map<String, dynamic>> jsonPaciente = List<Map<String, dynamic>>.from(jsonDecode(utf8.decode(response.bodyBytes)));
      List<Paciente> pacientes = jsonPaciente.map((e) => Paciente.fromMap(e)).toList();
      return pacientes; 
    } catch (e) {
      print('Error fetching pacientes: $e');
      return [];
    }
  }

}