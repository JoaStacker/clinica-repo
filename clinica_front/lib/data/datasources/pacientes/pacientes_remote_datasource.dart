import 'dart:convert';
import 'dart:io';

import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/model/paciente_request.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/services/dialog_service/dialog_service.dart';
import 'package:clinica_front/services/http_service_imp.dart';
import 'package:http/http.dart' as http;

sealed class PacientesRemoteDatasource {
  Future<List<Paciente>> getPaciente();
  Future<http.Response> savePaciente(PacienteRequest body);
}

class PacientesRemoteDatasourceImp extends PacientesRemoteDatasource {
  final HttpServiceImp _client = HttpServiceImp();
  final _dialogServices = locator<DialogService>();
  String uri = '/api/Paciente';
  
  @override
  Future<List<Paciente>> getPaciente() async {
    try {
      http.Response response = await _client.get(uri);
      List<Map<String, dynamic>> jsonPaciente = List<Map<String, dynamic>>.from(jsonDecode(utf8.decode(response.bodyBytes)));
      List<Paciente> pacientes = jsonPaciente.map((e) => Paciente.fromMap(e)).toList();
      return pacientes; 
    } catch (e) {
      await _dialogServices.showConfirmationDialog(title: 'Error', description: e.toString(), positiveLabel: 'Aceptar', negativeLabel: '');
      return [];
    }
  }

  @override
  Future<http.Response> savePaciente(PacienteRequest body) async{
    http.Response response = await _client.post(uri, body: body.toJson());
    if(response.statusCode == HttpStatus.created) {
      await _dialogServices.showConfirmationDialog(title: 'Registro de Paciente', description: 'Paciente creado con éxito', positiveLabel: 'Aceptar', negativeLabel: '');
    } else {
      await _dialogServices.showConfirmationDialog(title: 'Error', description: response.reasonPhrase.toString(), positiveLabel: 'Aceptar', negativeLabel: '');
    }
    return response;
  }

}