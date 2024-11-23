import 'package:clinica_front/data/model/historial_Paciente.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/repository/historia_clinica/historia_clinica_repository_imp.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class DetailPatientViewModel extends ChangeNotifier with NavegationServices {
  final _pacientesRepositoryImp = PacientesRepositoryImp();
  final _historiaClinicaRepositoryImp = HistoriaClinicaRepositoryImp();

  late Paciente _patient;
  Paciente get patient => _patient;

  late HistorialPaciente _historialPaciente;
  HistorialPaciente get historialPaciente => _historialPaciente;

  Future<Paciente> getPatient(String patientId) async {
    final patientList = await _pacientesRepositoryImp.getPaciente();
    final patient = patientList.singleWhere((e) => e.pacienteId.toString() == patientId);
    _patient = patient;
    return patient;
  }

  Future<HistorialPaciente> getHistoriaClinica() async {
    _historialPaciente = await _historiaClinicaRepositoryImp.getHistoriaClinica(_patient.pacienteId);
    return _historialPaciente;
  }
}