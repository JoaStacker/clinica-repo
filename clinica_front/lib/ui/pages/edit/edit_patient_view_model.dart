import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class EditPatientViewModel extends ChangeNotifier with NavegationServices{
  final MaskTextInputFormatter _birthdayFormatter = MaskTextInputFormatter(mask: '##/##/####', filter: {'#': RegExp(r'[0-9]')});
  MaskTextInputFormatter get birthdayFormatter => _birthdayFormatter;

  String? birthDayValidator(date) {
    if (date == null || date.isEmpty ) {
      return 'Ingrese una fecha por favor';
    }
    List<String> dateParts = date.split('/');
    if (dateParts.length < 3) {
      return 'El formato debe ser DD/MM/YYYY';
    }

    int? day = int.tryParse(dateParts[0]);
    int? month = int.tryParse(dateParts[1]);

    if (day == null || day < 1 || day > 31) {
      return 'Dia debe estar entre 1 y 31';
    }

    if (month == null || month < 1 || month > 12) {
      return 'Mes debe estar entre 1 y 12';
    }

    if (dateParts.length > 2) {
      int? year = int.tryParse(dateParts[2]);
      int olderThan20 = DateTime.now().year;
      int youngerThan110 = DateTime.now().year - 110;
      bool yearRangeIsIncorrect = year == null || year <= youngerThan110 || year >= olderThan20;

      if (yearRangeIsIncorrect) {
        return 'El año debe ser mayor a $youngerThan110 y menor a $olderThan20';
      }
    }
    return null;
  }
}