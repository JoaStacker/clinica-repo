import 'package:clinica_front/ui/pages/home/home_page.dart';
import 'package:clinica_front/ui/pages/login/login_page.dart';

final routes = {
  '/login': (context) => const LoginPage(),
  '/home': (context) => HomePage()
/*
  '/results': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as ResultadoSuela;
      return Results(resultadoSuela: args);
    } */
};
