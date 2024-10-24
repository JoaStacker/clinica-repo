import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:flutter/material.dart';

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