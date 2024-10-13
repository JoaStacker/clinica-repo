import 'package:clinica_front/ui/pages/detail_patient/detail_patient_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DetailPatientPage extends StatelessWidget {
  const DetailPatientPage({super.key, required this.patientId});
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => DetailPatientCommonWidget(patientId: patientId),
      tablet: (BuildContext context) => DetailPatientCommonWidget(patientId: patientId),
      desktop: (BuildContext context) => DetailPatientCommonWidget(patientId: patientId),
    );
  }
}