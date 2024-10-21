import 'package:clinica_front/ui/pages/detail_patient/detail_patient_page.dart';
import 'package:clinica_front/ui/pages/edit/edit_patient_page.dart';
import 'package:clinica_front/ui/pages/home/home_page.dart';
import 'package:clinica_front/ui/pages/login/login_page.dart';
import 'package:clinica_front/ui/pages/new_evolution/new_evolution_page.dart';
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
    path: '/patient/:id',
    builder: (context, state){
      final patientId = state.pathParameters['id']!;
      return DetailPatientPage(patientId: patientId);
    } 
  ),
  GoRoute(
    path: '/patient/:id/evolution',
    builder: (context, state){
      final patientId = state.pathParameters['id']!;
      return NewEvolutionPage(patientId: patientId);
    } 
  ),
];
