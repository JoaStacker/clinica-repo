import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/ui/pages/detail_patient/detail_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailPatientCommonWidget extends StatelessWidget {
  const DetailPatientCommonWidget({super.key, required this.patientId, required this.infoRowCount});
  final String patientId;
  final int infoRowCount; // New parameter

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
                return Center(heightFactor: 20, child: CircularProgressIndicator()); // Loading indicator
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}')); // Error handling
              } else if (snapshot.hasData) {
                var height = MediaQuery.of(context).size.height;
                return Container(
                  height: height,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('resources/images/patient_tile_background_screen.png'), fit: BoxFit.cover, scale: 4),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: height * 0.22,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2), // Shadow color
                              spreadRadius: 2, // Spread radius
                              blurRadius: 5, // Blur radius
                              offset: Offset(0, 3), // Offset for the shadow
                            ),
                          ],
                          color: kWhitePure,
                        ),
                        child: Column(
                          children: [
                            _backButtonAndName(vm),
                            SizedBox(height: 20),
                            Flexible(
                              child: _buildPatientInfoRow(
                                context,
                                Icons.person,
                                vm.patient.persona.cuil,
                                Icons.calendar_today,
                                vm.patient.persona.fechaDeNacimiento.substring(0, 10),
                                Icons.phone,
                                vm.patient.persona.telefono,
                                Icons.email,
                                vm.patient.persona.email,
                                infoRowCount: infoRowCount
                              ),
                            ),
                            SizedBox(height: 20),
                            Flexible(
                              child: _buildPatientInfoRow(
                                context,
                                Icons.person_off,
                                vm.patient.fechaDefuncion ?? 'N/A',
                                Icons.card_membership,
                                vm.patient.nroAfiliado.toString(),
                                Icons.local_airport_rounded,
                                vm.patient.pasaporte,
                                Icons.home,
                                '${vm.patient.persona.direccion.calle} ${vm.patient.persona.direccion.altura}, ${vm.patient.persona.direccion.localidad}, ${vm.patient.persona.direccion.provincia}',
                                infoRowCount: infoRowCount
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: ElevatedButton(
                            style: buttonStyle(context), onPressed: () {}, child: Text('NUEVA EVOLUCIÓN', style: bottonStyle)),
                      ),
                    ],
                  ),
                );
              }
              return SizedBox(); // Fallback if no data
            },
          );
        })));
  }

  Row _backButtonAndName(DetailPatientViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8),
          child: IconButton(
            padding: EdgeInsets.zero,
            color: kPrimaryColor,
            onPressed: () => viewModel.navigationReplace(path: '/home'),
            icon: Icon(Icons.arrow_back),
          ),
        ),
        Spacer(),
        Text(
          overflow: TextOverflow.ellipsis,
          viewModel.patient.persona.nombreApellido,
          style: textStyle24,
        ),
        Spacer()
      ],
    );
  }

  Widget _buildPatientInfoRow(BuildContext context, IconData icon1, String text1, IconData icon2, String text2, IconData icon3,
      String text3, IconData icon4, String text4, {int infoRowCount = 2}) {
    // Adjust the number of elements based on infoRowCount
    List<Widget> rowItems = [];
    if (infoRowCount >= 1) {
      rowItems.add(Icon(icon1, color: kPrimaryColor));
      rowItems.add(SizedBox(width: 5));
      rowItems.add(Expanded(child: Text(text1)));
      rowItems.add(Icon(icon2, color: kPrimaryColor));
      rowItems.add(SizedBox(width: 5));
      rowItems.add(Expanded(child: Text(text2)));
    }
    if (infoRowCount >= 3) {
      rowItems.add(Icon(icon3, color: kPrimaryColor));
      rowItems.add(SizedBox(width: 5));
      rowItems.add(Expanded(child: Text(text3)));
    }
    if (infoRowCount >= 4) {
      rowItems.add(Icon(icon4, color: kPrimaryColor));
      rowItems.add(SizedBox(width: 5));
      rowItems.add(Expanded(child: Text(text4)));
    }
    
    return Row(children: [
      Spacer(),
      ...rowItems,
      Spacer(),
    ]);
  }

  buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      fixedSize: Size(350, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: kTernary100);
}
