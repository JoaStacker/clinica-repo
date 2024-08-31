import 'package:clinica_front/ui/pages/login/login_page.dart';
import 'package:flutter/material.dart';

final routes = {
  '/login': (context) => const LoginPage(),
  '/home': (context) => Container()
/*
  '/results': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as ResultadoSuela;
      return Results(resultadoSuela: args);
    } */
};
