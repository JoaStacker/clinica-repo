import 'package:clinica_front/data/repository/pacientes/pacientes_repository_imp.dart';
import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier with NavegationServices{
  final TextEditingController _medicoSearchController = TextEditingController();
  TextEditingController get medicoSearchController => _medicoSearchController;
  final pacientesRepositoryImp = PacientesRepositoryImp();
}