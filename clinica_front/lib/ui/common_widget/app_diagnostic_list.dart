import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/data/model/historial_Paciente.dart';
import 'package:clinica_front/ui/pages/detail_patient/detail_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DiagnosticList extends StatelessWidget {
  const DiagnosticList({super.key, required this.width, required this.viewModel});
  final double width;
  final DetailPatientViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
                style: buttonStyle(context),
                onPressed: () => viewModel.navigationReplace(path: '/patient/${viewModel.patient.pacienteId}/evolution'),
                child: Text('NUEVA EVOLUCIÓN', style: bottonStyle)),
          ),
          FutureBuilder<HistorialPaciente>(
            future: viewModel.getHistoriaClinica(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data?.historiaClinica.isEmpty ?? true) {
                return Center(
                  child: Image.asset('resources/images/diagnosticos_empty.png', scale: 0.7),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.historialPaciente.historiaClinica.length,
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * width,
                    ),
                    itemBuilder: (context, index) {
                      final historiaClinica = viewModel.historialPaciente.historiaClinica[index];
                      return Padding(
                        padding: const EdgeInsets.all(2),
                        child: _DiagnosticCard(
                            evoluciones: historiaClinica.evoluciones,
                            diagnostico: historiaClinica.enfermedad,
                            observaciones: historiaClinica.observaciones),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      fixedSize: Size(350, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: kTernary100);
}

class _DiagnosticCard extends StatelessWidget {
  const _DiagnosticCard({required this.diagnostico, required this.evoluciones, required this.observaciones});

  final String diagnostico;
  final List<Evoluciones> evoluciones;
  final String observaciones;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kWhitePure,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(diagnostico, style: textGreenStyle24),
            SizedBox(height: 16),
            evolutionList(),
            SizedBox(height: 8),
            Text(
              observaciones,
              style: textBlackStyle14,
            ),
            SizedBox(height: 8),
            //if (connection) _actionButtons(),
          ],
        ),
      ),
    );
  }

  Wrap evolutionList() {
    return Wrap(
      spacing: 8.0, // Space between items
      runSpacing: 4.0, // Space between lines
      children: List.generate(evoluciones.length, (index) {
        final evolucion = evoluciones[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Evolución N°: ${index + 1}',
                  style: textBlackStyle24,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(DateFormat.yMd().format(evolucion.fechaCreacion), style: textBlackStyle14),
                    Text('${DateFormat.Hm().format(evolucion.fechaCreacion)} hs', style: textBlackStyle14)
                  ],
                )
              ],
            ),
            Text('Médico: ${evolucion.medico}', style: textBlackStyle14),
            Text('Informe: ${evolucion.informe}', style: textBlackStyle14),
            if(evolucion.textoPedido != null) 
              Text('Pedido de Laboratorio: ${evolucion.textoPedido}', style: textBlackStyle14),
            if(evolucion.indicacionesReceta != null)
              Text('Informe Receta Digital: ${evolucion.indicacionesReceta}', style: textBlackStyle14),
          ],
        );
      }),
    );
  }

/*   Row _actionButtons() {
    bool notAllow = false;
    if (lastDateTimeToEdit != null) {
      var today = DateTime.now();
      if (isSameDay(lastDateTimeToEdit, today)) {
        notAllow = false;
      } else {
        notAllow = lastDateTimeToEdit!.isBefore(today);
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RadiusColorButton(
          onTap: () => editVisit(),
          disable: notAllow,
          text: lastDateTimeToEdit != null ? 'Editar (Hasta el ${lastDateTimeToEdit!.formatToShowDDMM()})' : 'Editar',
        ),
        RadiusColorIconButton(
          onTap: () => deleteVisit(),
          disable: notAllow || !canDeleteteVisit,
          icon: (visit.status != VisitStatus.ReVisit) ? Icons.cleaning_services_rounded : Icons.delete_forever_outlined,
          backgroundColor: kSemaforoRed20,
          textColor: kSemaforoRed100,
        )
      ],
    );
  } */
}
