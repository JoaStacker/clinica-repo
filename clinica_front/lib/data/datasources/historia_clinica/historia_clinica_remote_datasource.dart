import 'package:clinica_front/data/model/historial_Paciente.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/services/dialog_service/dialog_service.dart';
import 'package:clinica_front/services/http_service_imp.dart';
import 'package:http/http.dart' as http;

abstract class HistoriaClinicaRemoteDatasource {
  Future<HistorialPaciente> getHistoriaClinica(int idPaciente);
}

class HistoriaClinicaRemoteDatasourceImp extends HistoriaClinicaRemoteDatasource {
  final HttpServiceImp _client = HttpServiceImp();
  final _dialogServices = locator<DialogService>();
  String uri = '/historia-clinica';
  
  @override
  Future<HistorialPaciente> getHistoriaClinica(int idPaciente) async {
    try {
      http.Response response = await _client.get(uri, queryParameters: {'idPaciente':  idPaciente.toString()});
      final historialPaciente = HistorialPaciente.fromJson(response.body);
      return historialPaciente; 
    } catch (e) {
      await _dialogServices.showConfirmationDialog(title: 'Error', description: '"Error al obtener historia clinica.', positiveLabel: 'Aceptar', negativeLabel: '');
      rethrow;
    }
  }
}