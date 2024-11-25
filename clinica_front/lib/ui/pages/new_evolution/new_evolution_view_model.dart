import 'package:clinica_front/data/datasources/diagnosticos/diagnosticos_remote_datasource.dart';
import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:clinica_front/data/model/evolucion_request.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/repository/evolucion/evolucion_repository_imp.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:clinica_front/services/autentication.dart';
import 'package:flutter/material.dart';

class NewEvolutionViewModel extends ChangeNotifier with NavegationServices {
  final _user = locator<AuthenticationService>().user;

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

  @override
  void dispose() {
    _diagnosticController.dispose();
    _obsEvol.dispose();
    _obsRecipe.dispose();
    _obsDelivery.dispose();
    super.dispose();
  }
}
