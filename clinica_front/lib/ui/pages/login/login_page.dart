import 'package:clinica_front/ui/pages/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; 
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => LoginScreen(sizeScreen:  width * 0.1),
      tablet: (BuildContext context) => LoginScreen(sizeScreen:  width * 0.2),
      desktop: (BuildContext context) => LoginScreen(sizeScreen:  width * 0.35),
    );
  }
}
