import 'package:clinica_front/data/datasources/diagnosticos/diagnosticos_remote_datasource.dart';
import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:clinica_front/data/model/evolucion_request.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/repository/evolucion/evolucion_repository_imp.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:clinica_front/services/autentication.dart';
import 'package:clinica_front/services/dialog_service/dialog_confirm_enum.dart';
import 'package:clinica_front/services/dialog_service/dialog_service.dart';
import 'package:flutter/material.dart';

class NewEvolutionViewModel extends ChangeNotifier with NavegationServices {
  final _user = locator<AuthenticationService>().user;
  final _dialogServices = locator<DialogService>();

  final _pacientesRepositoryImp = PacientesRepositoryImp();
  final _diagnosticosRepositoryImp = DiagnosticosRemoteDatasourceImp();
  final _evolucionRepositoryImp = EvolucionRepositoryImp();

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

  List<Diagnostico> _diagnosticos = [];
  List<Diagnostico> get diagnostico => _diagnosticos;

  List<Medicamento> _medicamentos = [];
  List<Medicamento> get medicamentos => _medicamentos;

  Future<Paciente> getPatient(String patientId) async {
    final patientList = await _pacientesRepositoryImp.getPaciente();
    final patient = patientList.singleWhere((e) => e.pacienteId.toString() == patientId);
    _patient = patient;
    return patient;
  }

  Future<List<Diagnostico>> getDiagnosticoPrevio() async {
    _diagnosticos = await _diagnosticosRepositoryImp.getDiagnosticoPrevio(_patient.pacienteId);
    return _diagnosticos;
  }

  void changeDigitalRecipe() {
    _isDigitalRecipe = !_isDigitalRecipe;
    notifyListeners();
  }

  void changeLaboratoryDelivery() {
    _isLaboratoryDelivery = !_isLaboratoryDelivery;
    notifyListeners();
  }

  void changeDiagnostic(String value) {
    _diagnosticString = value;
    notifyListeners();
  }

  void addNewDiagnostic() {
    _addDiagnostic = !_addDiagnostic;
    notifyListeners();
  }

  void saveEvolution() async {
    final diagnosticoId = _diagnosticos.firstWhere((e) => e.enfermedad == diagnosticString).diagnosticoId;

    final informe = _obsEvol.text;
    final medicoId = _user.medicoId;
    final pedidoText = _obsDelivery.text;
    final indicacionesReceta = _obsRecipe.text;

    final evolution = EvolutionRequest(
        medicoId: medicoId,
        diagnosticoId: diagnosticoId,
        informe: informe,
        textoPedido: pedidoText,
        medicamentos: _medicamentos,
        indicaciones: indicacionesReceta);

    await _evolucionRepositoryImp.saveEvolution(evolution, patient.pacienteId);
    navigationReplace(path: '/patient/${patient.pacienteId}');
  }

    void resetVariables() {
    _isLaboratoryDelivery = false;
    _isDigitalRecipe = false;
    _addDiagnostic = false;
    _diagnosticString = '';
    _diagnosticos.clear();
    _medicamentos.clear();
    _obsEvol.clear();
    _obsDelivery.clear();
    _obsRecipe.clear();
    _diagnosticController.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    resetVariables();
    super.dispose();
  }

  void goToBack() async {
    var result = await _dialogServices.showConfirmationDialog(
      title: '¿Estas seguro de volver a atras? ', 
      description: 'Perderás todos los datos cargados hasta el momento. ', 
      positiveLabel: 'Aceptar', negativeLabel: 'Cancelar');

    if(result!.confirmed == DialogConfirmEnum.positive){
      resetVariables();
      navigationReplace(path: '/patient/${patient.pacienteId}');
    }
  }
}
