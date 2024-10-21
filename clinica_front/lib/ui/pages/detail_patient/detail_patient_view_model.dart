import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class DetailPatientViewModel extends ChangeNotifier with NavegationServices {
  final pacientesRepositoryImp = PacientesRepositoryImp();
  late Paciente _patient;
  Paciente get patient => _patient; 

  Future<Paciente> getPatient(String patientId) async {
    final patientList = await pacientesRepositoryImp.getPaciente();
    final patient = patientList.singleWhere((e) => e.pacienteId.toString() == patientId);
    _patient = patient;
    return patient;
  }
}