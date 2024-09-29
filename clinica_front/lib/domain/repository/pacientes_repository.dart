import 'package:clinica_front/data/model/paciente.dart';

abstract class PacientesRepository{
  Future<List<Paciente>> getPaciente();
}