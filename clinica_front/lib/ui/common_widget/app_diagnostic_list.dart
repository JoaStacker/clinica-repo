import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:flutter/material.dart';

class DiagnosticList extends StatelessWidget {
  const DiagnosticList({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child:
                ElevatedButton(style: buttonStyle(context), onPressed: () {}, child: Text('NUEVA EVOLUCIÓN', style: bottonStyle)),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * width,
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(2),
                  child: _DiagnosticCard(
                    tipoDeEvolucion: 'Receta Digital',
                    diagnostico: 'Diabetes',
                    observaciones: 'Descripción de receta digital',
                    fecha: '10/10/2024',
                    hora: '14:30 hs',
                  ),
                );
              },
            ),
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
  const _DiagnosticCard({
    required this.diagnostico,
    required this.tipoDeEvolucion,
    required this.observaciones,
    required this.fecha,
    required this.hora
  });

  final String diagnostico;
  final String tipoDeEvolucion;
  final String observaciones;
  final String fecha;
  final String hora;

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  tipoDeEvolucion, //TODO:: PONER TIPO DE EVOLUCION
                  style: textGreenStyle24,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(fecha, style: textBlackStyle14),
                    Text(hora, style: textBlackStyle14)
                  ],
                )
              ],
            ),
            SizedBox(height: 16),
            Text(diagnostico, style: textBlackStyle24),
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
