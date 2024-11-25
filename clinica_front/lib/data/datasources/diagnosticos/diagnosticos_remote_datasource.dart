import 'dart:convert';
import 'dart:io';

import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/services/dialog_service/dialog_service.dart';
import 'package:clinica_front/services/http_service_imp.dart';
import 'package:http/http.dart' as http;

abstract class DiagnosticosRemoteDatasouce {
  Future<List<Diagnostico>> getDiagnosticoPrevio(int idPaciente);
  Future<void> saveNuevoDiagnostico(int idPaciente, String enfermedad);
}

class DiagnosticosRemoteDatasourceImp extends DiagnosticosRemoteDatasouce {
  final HttpServiceImp _client = HttpServiceImp();
  final _dialogServices = locator<DialogService>();
  String uri = '/diagnosticos';

  @override
  Future<List<Diagnostico>> getDiagnosticoPrevio(int idPaciente) async {
    List<Diagnostico> diagnosticos = [];

    try {
      http.Response response = await _client.get(uri, queryParameters: {'idPaciente': idPaciente.toString()});
      List<Map<String, dynamic>> jsonDiagnisticos = List<Map<String, dynamic>>.from(jsonDecode(utf8.decode(response.bodyBytes)));
      diagnosticos = jsonDiagnisticos.map((e) => Diagnostico.fromMap(e)).toList();
    } catch (e) {
      await _dialogServices.showConfirmationDialog(
          title: 'Error', description: 'Error al cargar lista de pacientes', positiveLabel: 'Aceptar', negativeLabel: '');
    }

    return diagnosticos;
  }

  @override
  Future<http.Response> saveNuevoDiagnostico(int idPaciente, String enfermedad) async {
    http.Response response = await _client
        .post(uri, queryParameters: {'idPaciente': idPaciente.toString()}, body: jsonEncode({ 'enfermedad': enfermedad, 'observaciones': '' }));
    if (response.statusCode != HttpStatus.noContent) {
      await _dialogServices.showConfirmationDialog(
          title: 'Error', description: response.reasonPhrase.toString(), positiveLabel: 'Aceptar', negativeLabel: '');
    }
    return response;
  }
}
