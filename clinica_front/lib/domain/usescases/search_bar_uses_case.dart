import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/domain/usescases/base_use_case.dart';

class SearchBarUsesCase extends BaseUseCase<String, List<Paciente>> {
  final _pacientesRepositoryImp = PacientesRepositoryImp();
  
  @override
  Future<List<Paciente>> execute(String input) async {
    final pacientesRepository = await _pacientesRepositoryImp.getPaciente();

    if (input.isEmpty) return pacientesRepository;
    
    final pacientes = pacientesRepository.where((e) => 
      e.pasaporte.toLowerCase().contains(input.toLowerCase()) || 
      e.persona.dni.toLowerCase().contains(input.toLowerCase())
    ).toList();

    return pacientes;
  }

}