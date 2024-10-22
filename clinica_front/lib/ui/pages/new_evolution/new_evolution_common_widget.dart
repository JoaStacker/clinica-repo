import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/enum/enum_diagnostics.dart';
import 'package:clinica_front/ui/common_widget/app_text_field.dart';
import 'package:clinica_front/ui/pages/new_evolution/new_evolution_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NewEvolutionCommonWidget extends StatelessWidget {
  const NewEvolutionCommonWidget({super.key, required this.patientId, required this.width});
  final String patientId;
  final double width;

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
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                            height: height * 0.2,
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
                            child: _backButtonAndName(vm, context)),
                        _bodyEvolution(vm, context),
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: ElevatedButton(
                              style: buttonStyle(context),
                              onPressed: () {},
                              child: Text('REGISTRAR EVOLUCIÓN', style: bottonStyle)),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox(); // Fallback if no data
            },
          );
        }));
  }

  buttonStyle(BuildContext context, {Color color = kTernary100}) => ElevatedButton.styleFrom(
      fixedSize: Size(350, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)), backgroundColor: color);

  Column _backButtonAndName(NewEvolutionViewModel viewModel, BuildContext context) {
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
        Text('Registro de Evolución', style: textBlackStyle24),
        SizedBox(height: 20),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width),
              child: Text(DateFormat.yMMMMd().format(DateTime.now()), style: textGrayStyle),
            ),
            Spacer()
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: width),
              child: Text('Hoy', style: textGrayStyle),
            ),
            Spacer()
          ],
        ),
      ],
    );
  }

  Padding _bodyEvolution(NewEvolutionViewModel viewModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width),
      child: Column(
        children: [
          SizedBox(height: 20),
          DropdownMenu<Diagnostics>(
            controller: viewModel.diagosticController,
            enableFilter: true,
            width: 350,
            requestFocusOnTap: true,
            leadingIcon: const Icon(Icons.search, color: kPrimaryColor),
            label: const Text('Diagnosticos'),
            inputDecorationTheme: const InputDecorationTheme(
              filled: false,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            onSelected: null,
            dropdownMenuEntries: Diagnostics.values.map<DropdownMenuEntry<Diagnostics>>(
              (Diagnostics diagnosticos) {
                return DropdownMenuEntry<Diagnostics>(
                  value: diagnosticos,
                  label: diagnosticos.value,
                );
              },
            ).toList(),
          ),
          SizedBox(height: 20),
          MedicationListScreen(),
          SizedBox(height: 20),
          GestureDetector(
            onTap: null,
            child: Container(
              alignment: Alignment.center,
              height: 30,
              width: 350,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.transparent, border: Border.all(color: Colors.grey)),
              child: Text('Seleccionar una plantilla de evolución', style: textBlackStyle14),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
              style: buttonStyle(context, color: viewModel.isDigitalRecipe ? kPrimaryColor : Colors.transparent),
              onPressed: () => viewModel.changeDigitalRecipe(),
              child: Text('Receta Digital', style: bottonStyle)),
          SizedBox(height: 10),
          Visibility(
            visible: viewModel.isDigitalRecipe,
            child: AppTextField(
              labelText: 'Instrucciones de recetas',
              labelStyle: hintStyle,
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: viewModel.obsEvol,
              textInputType: TextInputType.text,
              maxLine: 2,
              textCapitalization: TextCapitalization.characters,
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
              style: buttonStyle(context, color: viewModel.isLaboratoryDelivery ? kPrimaryColor : Colors.transparent),
              onPressed: () => viewModel.changeLaboratoryDelivery(),
              child: Text('Pedido de Laboratorio', style: bottonStyle)),
          SizedBox(height: 10),
          Visibility(
            visible: viewModel.isLaboratoryDelivery,
            child: AppTextField(
              labelText: 'Observaciones',
              labelStyle: hintStyle,
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: viewModel.obsEvol,
              textInputType: TextInputType.text,
              maxLine: 3,
              textCapitalization: TextCapitalization.characters,
            ),
          ),
          SizedBox(height: 10),
          Visibility(
            visible: viewModel.isLaboratoryDelivery,
            child: GestureDetector(
              onTap: null,
              child: Container(
                alignment: Alignment.center,
                height: 30,
                width: 350,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: Colors.transparent, border: Border.all(color: Colors.grey)),
                child: Text('Seleccionar una plantilla de pedido', style: textBlackStyle14),
              ),
            ),
          ),
          SizedBox(height: 10),
          AppTextField(
            labelText: 'Observaciones',
            labelStyle: hintStyle,
            scrollPadding: EdgeInsets.only(bottom: 40),
            controller: viewModel.obsEvol,
            textInputType: TextInputType.text,
            maxLine: 3,
            textCapitalization: TextCapitalization.characters,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}


class MedicationListScreen extends StatelessWidget {
  const MedicationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Medicamentos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Dosis',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                  ],
                ),
              ),
              MedicationCard(medication: 'Tafirol (30 mg)', dose: 'Tomar 1 cada 12 hs'),
            ],
          ),
        ),
        const SizedBox(height: 10),
        TextButton(
          onPressed: () {},
          child: Text(
            '+ Nuevo medicamento',
            style: text16Style
          ),
        ),
      ],
    );
  }
}

class MedicationCard extends StatelessWidget {
  final String medication;
  final String dose;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.dose,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(         
              children: [
                Expanded(
                  child: Text(
                    medication,
                    style: textGrayStyle
                  ),
                ),
                Expanded(
                  child: Text(
                    dose,
                    style: textGrayStyle
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_square, color: kPrimaryColor),
            onPressed: () {
              // Handle edit action
            },
          ),
        ],
      ),
    );
  }
}
