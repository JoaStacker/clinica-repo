import 'package:clinica_front/ui/pages/detail_patient/detail_patient_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DetailPatientPage extends StatelessWidget {
  const DetailPatientPage({super.key, required this.patientId});
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => DetailPatientCommonWidget(patientId: patientId, infoRowCount: 2, width: 0.15),
      tablet: (BuildContext context) => DetailPatientCommonWidget(patientId: patientId, infoRowCount: 3, width: 0.20),
      desktop: (BuildContext context) => DetailPatientCommonWidget(patientId: patientId, infoRowCount: 4, width: 0.25),
    );
  }
}
