import 'package:clinica_front/core/colors.dart';
import 'package:flutter/material.dart';

class DetailPatientCommonWidget extends StatelessWidget {
  const DetailPatientCommonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
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
                _backButtonAndName(context),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _backButtonAndName(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        IconButton(
          padding: EdgeInsets.zero,
          color: kPrimaryColor,
          onPressed: null,
          icon: Icon(Icons.arrow_back),
        ),
        Spacer(),
        Text(
          overflow: TextOverflow.ellipsis,
          'paciente.persona.nombreApellido',
          style: TextStyle(color: Colors.black87, fontSize: 24, fontWeight: FontWeight.w700),
        ),
        Spacer()
      ],
    );
  }
}
