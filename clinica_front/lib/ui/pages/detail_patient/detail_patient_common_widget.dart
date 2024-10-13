import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/ui/pages/detail_patient/detail_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPatientCommonWidget extends StatelessWidget {
  const DetailPatientCommonWidget({super.key, required this.patientId});
  final String patientId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            child: Consumer<DetailPatientViewModel>(builder: (BuildContext context, DetailPatientViewModel vm, Widget? child) {
          return FutureBuilder<Paciente>(
            future: vm.getPatient(patientId), // Fetch patient data
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator()); // Loading indicator
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}')); // Error handling
              } else if (snapshot.hasData) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('resources/images/patient_tile_background_screen.png'), fit: BoxFit.cover, scale: 4),
                  ),
                  child: Container(
                    height: 130,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: kWhitePure,
                    ),
                    child: Column(
                      children: [
                        _backButtonAndName(context, vm),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox(); // Fallback if no data
            },
          );
        })));
  }

  Row _backButtonAndName(context, DetailPatientViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          color: kPrimaryColor,
          onPressed: () => viewModel.navigationReplace(path: '/home'),
          icon: Icon(Icons.arrow_back),
        ),
        Spacer(),
        Text(
          overflow: TextOverflow.ellipsis,
          viewModel.patient.persona.nombreApellido,
          style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Spacer()
      ],
    );
  }
}
