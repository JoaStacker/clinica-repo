import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/data/model/medicamento_api_salud.dart';
import 'package:clinica_front/ui/pages/new_evolution/new_evolution_view_model.dart';
import 'package:flutter/material.dart';

class MedicationListScreen extends StatelessWidget {
  const MedicationListScreen({super.key, required this.viewModel});
  final NewEvolutionViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  children: const [
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
                        'Cantidad',
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
              _MedicationCard(viewModel: viewModel),
              _AddMedicationForm(viewModel: viewModel),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class _MedicationCard extends StatelessWidget {
  final NewEvolutionViewModel viewModel;

  const _MedicationCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final medications = viewModel.medicamentos; 
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: List.generate(
          medications.length,
          (index) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(medications[index].nombreComercial, style: textGrayStyle),
                    ),
                    Expanded(
                      child: Text(medications[index].cantidad.toString(), style: textGrayStyle),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit_square, color: kPrimaryColor),
                onPressed: () => viewModel.editReceta(index),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddMedicationForm extends StatelessWidget {
  final NewEvolutionViewModel viewModel;
  final ValueNotifier<int> _quantityNotifier = ValueNotifier<int>(1);

  _AddMedicationForm({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        searchMedicaments(context),
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove_circle, color: kPrimaryColor),
                  onPressed: () {
                    if (_quantityNotifier.value > 1) {
                      _quantityNotifier.value--;
                    }
                  },
                ),
                ValueListenableBuilder<int>(
                  valueListenable: _quantityNotifier,
                  builder: (context, quantity, child) {
                    return Text(quantity.toString());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.add_circle, color: kPrimaryColor),
                  onPressed: () {
                    _quantityNotifier.value++;
                  },
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                viewModel.changeCantidadMedicamento(_quantityNotifier.value);
                viewModel.isEditRecipe? viewModel.editMedicaments() : viewModel.addReceta();
              },
              child: Text(viewModel.isEditRecipe? '+ Editar': '+ Añadir', style: text16Style),
            ),
          ),
        ),
      ],
    );
  }

  FutureBuilder searchMedicaments(BuildContext context) {
    return FutureBuilder(
      future: viewModel.evolucionRepositoryImp.getMedicamentosApiSalud(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(); // Show loading indicator
        }

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownMenu<MedicamentoApiSalud>(
              controller: viewModel.medicamentoController,
              enableFilter: true,
              width: MediaQuery.of(context).size.width * 0.28,
              menuHeight: 250,
              requestFocusOnTap: true,
              leadingIcon: const Icon(Icons.search, color: kPrimaryColor),
              label: const Text('Medicamentos'),
              inputDecorationTheme: const InputDecorationTheme(
                filled: false,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              onSelected: (value) => viewModel.changeMedicament(value!),
              dropdownMenuEntries: snapshot.data!.map<DropdownMenuEntry<MedicamentoApiSalud>>(
                (MedicamentoApiSalud medicamento) {
                  return DropdownMenuEntry<MedicamentoApiSalud>(
                    value: medicamento,
                    label: '${medicamento.descripcion} ${medicamento.formato}',
                  );
                },
              ).toList(),
            ),
          ),
        );
      },
    );
  }
}
