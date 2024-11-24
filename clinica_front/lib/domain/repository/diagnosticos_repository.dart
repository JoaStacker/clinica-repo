import 'package:clinica_front/data/model/diagnostico.dart';

abstract class DiagnosticosRepository {
  Future<List<Diagnostico>> getDiagnosticoPrevio(int idPaciente);

}