import 'package:clinica_front/data/datasources/diagnosticos/diagnosticos_remote_datasource.dart';
import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class NewEvolutionViewModel extends ChangeNotifier with NavegationServices {
  final _pacientesRepositoryImp = PacientesRepositoryImp();
  final _diagnosticosRepositoryImp = DiagnosticosRemoteDatasourceImp();

  final TextEditingController _obsEvol = TextEditingController();
  TextEditingController get obsEvol => _obsEvol;
  final TextEditingController _obsDelivery = TextEditingController();
  TextEditingController get obsDelivery => _obsDelivery;
  final TextEditingController _obsRecipe = TextEditingController();
  TextEditingController get obsRecipe => _obsRecipe;
  final TextEditingController _diagnosticController = TextEditingController();
  TextEditingController get diagosticController => _diagnosticController;
  late Paciente _patient;
  Paciente get patient => _patient;
  bool _isLaboratoryDelivery = false;
  bool get isLaboratoryDelivery => _isLaboratoryDelivery;
  bool _isDigitalRecipe = false;
  bool get isDigitalRecipe => _isDigitalRecipe;
  bool _addDiagnostic = false;
  bool get addDiagnostic => _addDiagnostic;
  String _diagnosticString = '';
  String get diagnosticString => _diagnosticString;


  Future<Paciente> getPatient(String patientId) async {
    final patientList = await _pacientesRepositoryImp.getPaciente();
    final patient = patientList.singleWhere((e) => e.pacienteId.toString() == patientId);
    _patient = patient;
    return patient;
  }


  Future<List<Diagnostico>> getDiagnosticoPrevio() async {
    return await _diagnosticosRepositoryImp.getDiagnosticoPrevio(_patient.pacienteId);
  }

  void changeDigitalRecipe(){
    _isDigitalRecipe = !_isDigitalRecipe;
    notifyListeners();
  }

  void changeLaboratoryDelivery(){
    _isLaboratoryDelivery = !_isLaboratoryDelivery;
    notifyListeners();
  }
  
  void changeDiagnostic(String value){
    _diagnosticString = value;
    notifyListeners();
  }

  void addNewDiagnostic(){
    _addDiagnostic = !_addDiagnostic;
    notifyListeners();
  }


  @override
  void dispose() {
    _diagnosticController.dispose();
    _obsEvol.dispose();
    _obsRecipe.dispose();
    _obsDelivery.dispose();
    super.dispose();
  }

}