import 'package:clinica_front/data/datasources/historia_clinica/historia_clinica_remote_datasource.dart';
import 'package:clinica_front/data/model/historial_Paciente.dart';
import 'package:clinica_front/domain/repository/historia_clinica.dart';

class HistoriaClinicaRepositoryImp extends HistoriaClinicaRepository {
  final _historiaClinicaRemoteDatasourceImp = HistoriaClinicaRemoteDatasourceImp();

  @override
  Future<HistorialPaciente> getHistoriaClinica(int idPaciente) {
    final historiaClinica = _historiaClinicaRemoteDatasourceImp.getHistoriaClinica(idPaciente);
    return historiaClinica;
  }

}