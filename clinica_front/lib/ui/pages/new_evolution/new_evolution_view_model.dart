import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class NewEvolutionViewModel extends ChangeNotifier with NavegationServices {
  final pacientesRepositoryImp = PacientesRepositoryImp();
  final TextEditingController _obsEvol = TextEditingController();
  TextEditingController get obsEvol => _obsEvol;
  final TextEditingController _diagnosticController = TextEditingController();
  TextEditingController get diagosticController => _diagnosticController;
  late Paciente _patient;
  Paciente get patient => _patient;
  bool _isLaboratoryDelivery = false;
  bool get isLaboratoryDelivery => _isLaboratoryDelivery;
  bool _isDigitalRecipe = false;
  bool get isDigitalRecipe => _isDigitalRecipe;


  Future<Paciente> getPatient(String patientId) async {
    final patientList = await pacientesRepositoryImp.getPaciente();
    final patient = patientList.singleWhere((e) => e.pacienteId.toString() == patientId);
    _patient = patient;
    return patient;
  }

  void changeDigitalRecipe(){
    _isDigitalRecipe = !_isDigitalRecipe;
    notifyListeners();
  }

  void changeLaboratoryDelivery(){
    _isLaboratoryDelivery = !_isLaboratoryDelivery;
    notifyListeners();
  }

}