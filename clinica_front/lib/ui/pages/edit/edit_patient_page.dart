import 'package:clinica_front/ui/pages/edit/edit_patient_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditPatientPage extends StatelessWidget {
  const EditPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => EditPatientCommonWidget(width: width * 0.05),
      tablet: (BuildContext context) => EditPatientCommonWidget(width: width * 0.1),
      desktop: (BuildContext context) => EditPatientCommonWidget(width: width * 0.2),
    );
  }
}