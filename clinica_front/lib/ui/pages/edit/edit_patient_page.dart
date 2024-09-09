import 'package:clinica_front/ui/pages/edit/edit_patient_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class EditPatientPage extends StatelessWidget {
  const EditPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => EditPatientCommonWidget(),
      tablet: (BuildContext context) => EditPatientCommonWidget(),
      desktop: (BuildContext context) => EditPatientCommonWidget(),
    );
  }
}