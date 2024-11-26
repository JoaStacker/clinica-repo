import 'dart:convert';
import 'dart:io';

import 'package:clinica_front/data/model/evolucion_request.dart';
import 'package:clinica_front/data/model/medicamento_api_salud.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/services/dialog_service/dialog_service.dart';
import 'package:clinica_front/services/http_service_imp.dart';
import 'package:http/http.dart' as http;

abstract class EvolucionRemoteDatasource {
  Future<http.Response> saveEvolution(EvolutionRequest body, int pacienteId);
  Future<List<MedicamentoApiSalud>> getMedicamentosApiSalud();
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
  
  @override
  Future<List<MedicamentoApiSalud>> getMedicamentosApiSalud() async {
    List<MedicamentoApiSalud> medicamentos = [];
    String uri = 'https://istp1service.azurewebsites.net/api/servicio-salud/medicamentos/todos?pagina=8&limite=20';

    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: {
          'accept': '*/*',
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        List<Map<String, dynamic>> jsonParse = List<Map<String, dynamic>>.from(jsonDecode(utf8.decode(response.bodyBytes)));
        medicamentos = jsonParse.map((e) => MedicamentoApiSalud.fromMap(e)).toList();
      } else {
        await _dialogServices.showConfirmationDialog(
          title: 'Error', 
          description: 'No se pudo obtener medicamentos.', 
          positiveLabel: 'Aceptar', negativeLabel: '');
      }
    } catch (e) {
      await _dialogServices.showConfirmationDialog(
        title: 'Error', 
        description: 'Ocurrió un error al realizar la solicitud', 
        positiveLabel: 'Aceptar', negativeLabel: '');
    }
    
    return medicamentos;
  }


}