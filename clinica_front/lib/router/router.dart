import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/ui/pages/detail_patient/detail_patient_page.dart';
import 'package:clinica_front/ui/pages/edit/edit_patient_page.dart';
import 'package:clinica_front/ui/pages/home/home_page.dart';
import 'package:clinica_front/ui/pages/login/login_page.dart';
import 'package:go_router/go_router.dart';

final List<RouteBase> router = [
  GoRoute(
    path: '/login',
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  ),
  GoRoute(
    path: '/edit',
    builder: (context, state) => EditPatientPage(),
  ),
  GoRoute(
    path: '/patient',
    builder: (context, state){
      final patient = state.extra as Paciente;
      return DetailPatientPage(patient: patient);
    } 
  ),
];
