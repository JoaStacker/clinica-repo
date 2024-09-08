import 'package:clinica_front/core/colors.dart';
import 'package:clinica_front/core/text.dart';
import 'package:clinica_front/ui/pages/common_widget/app_text_field.dart';
import 'package:clinica_front/ui/pages/login/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key, required this.sizeScreen});
  final double sizeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<LoginViewModel>(builder: (BuildContext buildContextBuilder, LoginViewModel vm, Widget? child) {
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizeScreen)
                          .add(EdgeInsets.only(bottom: 100 + MediaQuery.of(context).viewInsets.bottom)),
                      child: loginForm(context, vm),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      })
    );
  }

  Column loginForm(BuildContext context, LoginViewModel viewModel) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 25),
        Image.asset('resources/images/clinica.png', scale: 0.8),
        SizedBox(height: 25),
        AppTextField(
          labelText: 'USUARIO',
          labelStyle: hintStyle,
          scrollPadding: EdgeInsets.only(bottom: 40),
          controller: viewModel.userInput,
          padding: EdgeInsets.only(bottom: 32),
          textInputType: TextInputType.emailAddress,
          textCapitalization: TextCapitalization.characters,
        ),
        SizedBox(height: 5),
        AppTextField(
            labelText: 'CONTRASEÑA',
            labelStyle: hintStyle,
            scrollPadding: EdgeInsets.only(bottom: 40),
            controller: viewModel.passwordInput,
            padding: EdgeInsets.only(bottom: 40),
            textInputType: TextInputType.visiblePassword,
            passwordField: viewModel.passwordField,
            errorText: viewModel.failureMessage,
            suffixIcon: GestureDetector(
              child: Icon(viewModel.passwordField ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: Colors.grey),
              onTap: () => viewModel.changePasswordField(),
            ),
            onChange: (text) => viewModel.failureMessage.isNotEmpty? viewModel.setFailureMessage('') : null),
        Container(
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(15.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 2),
                blurRadius: 10.0,
                color: Colors.black.withOpacity(0.3),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                fixedSize: Size(size.width, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
            onPressed: null,
            child: Text('INICIAR SESIÓN', style: textTitle)),
        ),
      ],
    );
  }
}
