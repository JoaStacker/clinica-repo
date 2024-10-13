import 'package:clinica_front/ui/pages/detail_patient/detail_patient_common_widget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DetailPatientPage extends StatelessWidget {
  const DetailPatientPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => DetailPatientCommonWidget(),
      tablet: (BuildContext context) => DetailPatientCommonWidget(),
      desktop: (BuildContext context) => DetailPatientCommonWidget(),
    );
  }
}