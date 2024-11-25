import 'dart:io';

import 'package:clinica_front/data/model/evolucion_request.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/services/dialog_service/dialog_service.dart';
import 'package:clinica_front/services/http_service_imp.dart';
import 'package:http/http.dart' as http;

abstract class EvolucionRemoteDatasource {
  Future<http.Response> saveEvolution(EvolutionRequest body, int pacienteId);
}

class EvolucionRemoteDatasourceImp extends EvolucionRemoteDatasource {
  final HttpServiceImp _client = HttpServiceImp();
  final _dialogServices = locator<DialogService>();
  String uri = '/evoluciones';

  @override
  Future<http.Response> saveEvolution(EvolutionRequest body, int pacienteId) async {
    http.Response response = await _client.post(uri, queryParameters: { 'idPaciente': pacienteId.toString() } ,body: body.toJson());
    if(response.statusCode == HttpStatus.created) {
      await _dialogServices.showConfirmationDialog(title: 'Registro de Evolución', description: 'Evolución creado con éxito', positiveLabel: 'Aceptar', negativeLabel: '');
    } else {
      await _dialogServices.showConfirmationDialog(title: 'Error', description: response.reasonPhrase.toString(), positiveLabel: 'Aceptar', negativeLabel: '');
    }
    return response;
  }
  }