import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/ui/pages/edit/edit_patient_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../common_widget/input_white.dart';

class EditPatientCommonWidget extends StatelessWidget {
  const EditPatientCommonWidget({super.key, required this.width});
  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<EditPatientViewModel>(builder: (BuildContext context, EditPatientViewModel vm, Widget? child) {
      return Stack(
        children: [
          Image.asset(
            'resources/images/doctor_tile_background_screen.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: _EditFieldsAppBar(back: () => vm.navigatorPush('/home')),
            resizeToAvoidBottomInset: true,
            body: Form(
              key: vm.formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 10),
                      editInformationPersonal(context, vm),
                      Padding(
                        padding: EdgeInsets.all(40),
                        child: ElevatedButton(
                            style: buttonStyle(context), onPressed: () => vm.savePaciente(), child: Text('GUARDAR INFORMACIÓN', style: bottonStyle)),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      fixedSize: Size(350, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: kTernary100);

  Column editInformationPersonal(BuildContext context, EditPatientViewModel viewModel) {
    return Column(children: [
      SizedBox(height: 20),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.01),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Nombre y Apellido: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (text) => viewModel.nombreApellido = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'DNI: ',
                initString: '',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(9),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (text) => viewModel.dni = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'CUIL: ',
                initString: '',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(14),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9 -]')),
                ],
                onChanged: (text) => viewModel.cuil = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Fecha de nacimiento: ',
                initString: '',
                hintText: 'YYYY-MM-DD',
                keyboardType: TextInputType.number,
                inputFormatters: [viewModel.birthdayFormatter],
                validator: (date) => viewModel.birthDayValidator(date),
                onChanged: (text) => viewModel.fechaDeNaciento = text,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Email: ',
                initString: '',
                keyboardType: TextInputType.emailAddress,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
                onChanged: (text) => viewModel.email = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Telefono: ',
                initString: '',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(14),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (text) => viewModel.telefono = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Nro de afiliado: ',
                initString: '',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                onChanged: (text) => viewModel.nroAfiliado = int.parse(text),
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Pasaporte: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]')),
                ],
                onChanged: (text) => viewModel.pasaporte = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Provincia: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z á-é-í-ó-ú]')),
                ],
                onChanged: (text) => viewModel.provincia = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Localidad: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (text) => viewModel.localidad = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Codigo Postal: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z 0-9]')),
                ],
                onChanged: (text) => viewModel.cop = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Calle: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (text) => viewModel.calle = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Altura: ',
                initString: '',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(5),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                onChanged: (text) => viewModel.altura = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Piso: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3),
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                onChanged: (text) => viewModel.piso = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
              InputWhite(
                labelText: 'Departamento: ',
                initString: '',
                keyboardType: TextInputType.text,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                  FilteringTextInputFormatter.allow(RegExp('[a-z A-Z]')),
                ],
                onChanged: (text) => viewModel.departamento = text,
                validator: (p0) => p0 == null || p0.isEmpty? 'Campo Obligatorio' : null,
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      )
    ]);
  }
}

class _EditFieldsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _EditFieldsAppBar({required this.back});

  final Function() back;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 100,
      backgroundColor: Colors.transparent,
      leading: backIcon(context),
      actions: const [SizedBox(width: 54)],
      title: Center(
        child: Text('EDITANDO INFORMACIÓN PERSONAL', maxLines: 2, textAlign: TextAlign.center, style: textStyle24),
      ),
    );
  }

  Center backIcon(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => back(),
        child: Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: kPrimaryColor, width: 2),
          ),
          child: Icon(
            Icons.close,
            color: kPrimaryColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
