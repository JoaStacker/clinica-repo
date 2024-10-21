import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/ui/pages/new_evolution/new_evolution_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewEvolutionCommonWidget extends StatelessWidget {
  const NewEvolutionCommonWidget({super.key, required this.patientId});
  final String patientId;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Consumer<NewEvolutionViewModel>(builder: (BuildContext context, NewEvolutionViewModel vm, Widget? child) {
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          height: height * 0.15,
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
                          child: _backButtonAndName(vm)),
                      
                    ],
                  ),
                );
              }
              return SizedBox(); // Fallback if no data
            },
          );
        }));
  }

  Column _backButtonAndName(NewEvolutionViewModel viewModel) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: IconButton(
                padding: EdgeInsets.zero,
                color: kPrimaryColor,
                onPressed: () => viewModel.navigationReplace(path: '/patient/$patientId'),
                icon: Icon(Icons.close),
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
        ),
        SizedBox(height: 20),
        Text(
          overflow: TextOverflow.ellipsis,
          'Registro de Evolución',
          style: textBlackStyle24,
        ),
      ],
    );
  }

}