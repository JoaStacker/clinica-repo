import 'package:clinica_front/data/model/historial_Paciente.dart';

abstract class HistoriaClinicaRepository{
  Future<HistorialPaciente> getHistoriaClinica(int idPaciente);
}