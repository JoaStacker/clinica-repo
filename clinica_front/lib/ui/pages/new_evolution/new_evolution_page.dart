import 'package:clinica_front/ui/pages/new_evolution/new_evolution_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class NewEvolutionPage extends StatelessWidget {
  const NewEvolutionPage({super.key, required this.patientId});
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => NewEvolutionCommonWidget(patientId: patientId),
      tablet: (BuildContext context) => NewEvolutionCommonWidget(patientId: patientId),
      desktop: (BuildContext context) => NewEvolutionCommonWidget(patientId: patientId),
    );
  }
}
