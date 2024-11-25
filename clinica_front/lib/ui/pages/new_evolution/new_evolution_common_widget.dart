import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/data/model/diagnostico.dart';
import 'package:clinica_front/data/model/paciente.dart';
import 'package:clinica_front/enum/enum_diagnostics.dart';
import 'package:clinica_front/ui/common_widget/app_medication_list.dart';
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
        body: Builder(
          builder: (BuildContext context) {
            final vm = Provider.of<NewEvolutionViewModel>(context); // Accessing the ViewModel directly
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
                          Visibility(
                            visible: vm.diagnosticString.isNotEmpty,
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: ElevatedButton(
                                  style: buttonStyle(context),
                                  onPressed: () => vm.saveEvolution(),
                                  child: Text('REGISTRAR EVOLUCIÓN', style: bottonStyle)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return SizedBox(); // Fallback if no data
              },
            );
          },
        ));
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
          _buildDiagnosticComponent(viewModel),
          SizedBox(height: 20),
          _buildDigitalRecipe(viewModel, context),
          SizedBox(height: 10),
          _buildLaboratoryDelivery(viewModel, context),
          SizedBox(height: 10),
          Visibility(
            visible: viewModel.diagnosticString.isNotEmpty,
            child: AppTextField(
              labelText: 'Observaciones de la evolución',
              labelStyle: hintStyle,
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: viewModel.obsEvol,
              textInputType: TextInputType.text,
              maxLine: 3,
              textCapitalization: TextCapitalization.characters,
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Visibility _buildDigitalRecipe(NewEvolutionViewModel viewModel, BuildContext context) {
    return Visibility(
      visible: viewModel.diagnosticString.isNotEmpty,
      child: Column(
        children: [
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
          Visibility(visible: viewModel.isDigitalRecipe, child: MedicationListScreen()),
          SizedBox(height: 10),
          Visibility(
            visible: viewModel.isDigitalRecipe,
            child: AppTextField(
              labelText: 'Instrucciones de recetas',
              labelStyle: hintStyle,
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: viewModel.obsRecipe,
              textInputType: TextInputType.text,
              maxLine: 2,
              textCapitalization: TextCapitalization.characters,
            ),
          ),
        ],
      ),
    );
  }

  Visibility _buildLaboratoryDelivery(NewEvolutionViewModel viewModel, BuildContext context) {
    return Visibility(
        visible: viewModel.diagnosticString.isNotEmpty,
        child: Column(children: [
          ElevatedButton(
              style: buttonStyle(context, color: viewModel.isLaboratoryDelivery ? kPrimaryColor : Colors.transparent),
              onPressed: () => viewModel.changeLaboratoryDelivery(),
              child: Text('Pedido de Laboratorio', style: bottonStyle)),
          SizedBox(height: 10),
          Visibility(
            visible: viewModel.isLaboratoryDelivery,
            child: AppTextField(
              labelText: 'Observaciones del pedido',
              labelStyle: hintStyle,
              scrollPadding: EdgeInsets.only(bottom: 40),
              controller: viewModel.obsDelivery,
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
        ]));
  }

  Row _buildDiagnosticComponent(NewEvolutionViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        viewModel.addDiagnostic? 
        DropdownMenu<NewDiagnostics>(
          controller: viewModel.diagosticController,
          enableFilter: true,
          width: 285,
          menuHeight: 250,
          requestFocusOnTap: true,
          leadingIcon: const Icon(Icons.search, color: kPrimaryColor),
          label: const Text('Nuevos Diagnosticos'),
          inputDecorationTheme: const InputDecorationTheme(
            filled: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
          onSelected: (value) => viewModel.changeDiagnostic(value?.value ?? ''),
          dropdownMenuEntries: NewDiagnostics.values.map<DropdownMenuEntry<NewDiagnostics>>(
            (NewDiagnostics diagnosticos) {
              return DropdownMenuEntry<NewDiagnostics>(
                value: diagnosticos,
                label: diagnosticos.value,
              );
            },
          ).toList(),
        ) :
        FutureBuilder<List<Diagnostico>>(
          future: viewModel.getDiagnosticoPrevio(), // Fetch the list of Diagnosticos
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SizedBox(); // Show loading indicator
            }
            
            return DropdownMenu<Diagnostico>(
              controller: viewModel.diagosticController,
              enableFilter: true,
              width: 285,
              menuHeight: 250,
              requestFocusOnTap: true,
              leadingIcon: const Icon(Icons.search, color: kPrimaryColor),
              label: const Text('Diagnosticos Previos'),
              inputDecorationTheme: const InputDecorationTheme(
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onSelected: (value) => viewModel.changeDiagnostic(value?.enfermedad ?? ''),
              dropdownMenuEntries: snapshot.data!.map<DropdownMenuEntry<Diagnostico>>(
                (Diagnostico diagnostico) {
                  return DropdownMenuEntry<Diagnostico>(
                    value: diagnostico,
                    label: diagnostico.enfermedad, // Adjust this based on your Diagnostico model
                  );
                },
              ).toList(),
            );
          },
        ),
        SizedBox(width: 10),
        IconButton(
          onPressed: () => viewModel.addNewDiagnostic(), 
          icon: Icon(
            viewModel.addDiagnostic? Icons.indeterminate_check_box_rounded : Icons.add_box_rounded, 
            size: 30, color: kPrimaryColor)
        )
      ],
    );
  }
}
