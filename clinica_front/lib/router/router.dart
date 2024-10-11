import 'package:clinica_front/ui/pages/detail_patient/detail_patient_page.dart';
import 'package:clinica_front/ui/pages/edit/edit_patient_page.dart';
import 'package:clinica_front/ui/pages/home/home_page.dart';
import 'package:clinica_front/ui/pages/login/login_page.dart';

final routes = {
  '/login': (context) => const LoginPage(),
  '/home': (context) => HomePage(),
  '/edit': (context) => EditPatientPage(),
  '/patient': (context) => DetailPatientPage()
};
