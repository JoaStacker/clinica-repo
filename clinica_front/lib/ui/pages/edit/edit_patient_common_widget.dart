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
            appBar: _EditFieldsAppBar(back: () => Navigator.of(context).pop()),
            resizeToAvoidBottomInset: true,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 10),
                  editInformationPersonal(context, vm),
                  Padding(
                    padding: EdgeInsets.all(40),
                    child: ElevatedButton(
                        style: buttonStyle(context), onPressed: () {}, child: Text('GUARDAR INFORMACIÓN', style: bottonStyle)),
                  ),
                  SizedBox(height: 20),
                ],
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

  SingleChildScrollView editInformationPersonal(BuildContext context, EditPatientViewModel viewModel) {
    return SingleChildScrollView(
      child: Column(children: [
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
                  labelText: 'Nombre: ',
                  initString: '',
                  keyboardType: TextInputType.text,
                  enable: true,
                  onChanged: null,
                ),
                SizedBox(height: 20),
                InputWhite(
                  labelText: 'Apellido: ',
                  initString: '',
                  keyboardType: TextInputType.text,
                  enable: true,
                  onChanged: null,
                ),
                SizedBox(height: 20),
                InputWhite(
                  labelText: 'DNI: ',
                  initString: '',
                  keyboardType: TextInputType.text,
                  inputFormatters: [LengthLimitingTextInputFormatter(9)],
                  enable: true,
                  onChanged: null,
                ),
                SizedBox(height: 20),
                InputWhite(
                  labelText: 'Fecha de nacimiento: ',
                  initString: '',
                  keyboardType: TextInputType.number,
                  hintText: 'dd/mm/yyyy',
                  inputFormatters: [viewModel.birthdayFormatter],
                  validator: (date) => viewModel.birthDayValidator(date),
                  onChanged: null,
                ),
                SizedBox(height: 20),
                InputWhite(
                  labelText: 'Direccion: ',
                  initString: '',
                  keyboardType: TextInputType.text,
                  enable: true,
                  onChanged: null,
                ),
                SizedBox(height: 20),
                InputWhite(
                  labelText: 'Obra Social: ',
                  initString: '',
                  keyboardType: TextInputType.text,
                  enable: true,
                  onChanged: null,
                ),
                SizedBox(height: 20),
                InputWhite(
                  labelText: 'Nro de afiliado: ',
                  initString: '',
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(20)],
                  enable: true,
                  onChanged: null,
                ),
              ],
            ),
          ),
        )
      ]),
    );
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
