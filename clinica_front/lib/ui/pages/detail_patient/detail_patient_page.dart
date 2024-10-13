import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/ui/pages/detail_patient/detail_patient_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DetailPatientPage extends StatelessWidget {
  const DetailPatientPage({super.key, required this.patient});
  final Paciente patient;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => DetailPatientCommonWidget(patient: patient),
      tablet: (BuildContext context) => DetailPatientCommonWidget(patient: patient),
      desktop: (BuildContext context) => DetailPatientCommonWidget(patient: patient),
    );
  }
}