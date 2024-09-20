import 'package:clinica_front/ui/pages/home/home_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => HomeScreenMobile(),
      tablet: (BuildContext context) => HomeScreenTablet(),
      desktop: (BuildContext context) => HomeScreenDesktop(),
    );
  }
}