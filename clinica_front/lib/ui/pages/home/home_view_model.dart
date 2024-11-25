import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/domain/usescases/search_bar_uses_case.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier with NavegationServices{
  final TextEditingController _medicoSearchController = TextEditingController();
  TextEditingController get medicoSearchController => _medicoSearchController;
  final searchBarUsesCase = SearchBarUsesCase();

  Future<List<Paciente>> getPaciente() async => await searchBarUsesCase.execute(medicoSearchController.text);

  void reset() => notifyListeners();
}