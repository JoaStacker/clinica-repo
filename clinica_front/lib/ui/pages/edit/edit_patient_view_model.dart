import 'package:clinica_front/data/model/paciente_request.dart';
import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditPatientViewModel extends ChangeNotifier with NavegationServices {
  final pacientesRepositoryImp = PacientesRepositoryImp();
  final MaskTextInputFormatter _birthdayFormatter = MaskTextInputFormatter(mask: '####-##-##', filter: {'#': RegExp(r'[0-9]')});
  MaskTextInputFormatter get birthdayFormatter => _birthdayFormatter;
  final _formKey = GlobalKey<FormState>();
  GlobalKey get formKey => _formKey;

  String cuil = '';
  String dni = '';
  String email = '';
  String telefono = '';
  String nombreApellido = '';
  String provincia = '';
  String localidad = '';
  String cop = '';
  String calle = '';
  String altura = '';
  String piso = '';
  String departamento = '';
  String pasaporte = '';
  int nroAfiliado = 0;
  String fechaDeNaciento = '';

  String? birthDayValidator(date) {
    if (date == null || date.isEmpty) {
      return 'Ingrese una fecha por favor';
    }
    List<String> dateParts = date.split('-');
    
    if (dateParts.length != 3) {
      return 'El formato debe ser YYYY-MM-DD';
    }

    int? year = int.tryParse(dateParts[0]);
    int olderThan20 = DateTime.now().year;
    int youngerThan110 = DateTime.now().year - 110;
    bool yearRangeIsIncorrect = year == null || year <= youngerThan110 || year >= olderThan20;

    if (yearRangeIsIncorrect) {
      return 'El año debe ser mayor a $youngerThan110 y menor a $olderThan20';
    }

    int? month = int.tryParse(dateParts[1]);
    if (month == null || month < 1 || month > 12) {
      return 'Mes debe estar entre 1 y 12';
    }

    int? day = int.tryParse(dateParts[2]);
    if (day == null || day < 1 || day > 31) {
      return 'Dia debe estar entre 1 y 31';
    }

    return null;
  }

  void savePaciente() async {
    if (_formKey.currentContext == null || _formKey.currentState!.validate()){
      PacienteRequest pacienteRequest = PacienteRequest(
          cuil: cuil,
          dni: dni,
          email: email,
          telefono: telefono,
          nombreApellido: nombreApellido,
          provincia: provincia,
          localidad: localidad,
          cop: cop,
          calle: calle,
          altura: altura,
          piso: piso,
          departamento: departamento,
          pasaporte: pasaporte,
          nroAfiliado: nroAfiliado,
          fechaDeNaciento: fechaDeNaciento);
      await pacientesRepositoryImp.savePaciente(pacienteRequest);
      navigatorPush('/home');
    }
  }
}
