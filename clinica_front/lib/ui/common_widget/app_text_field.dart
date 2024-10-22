import 'package:clinica_front/core/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {super.key,
      required this.scrollPadding,
      required this.controller,
      this.padding = const EdgeInsets.all(4.0),
      required this.textInputType,
      this.width = 300,
      this.hintText,
      this.hintStyle,
      this.labelText,
      this.labelStyle,
      this.maxLength,
      this.passwordField = false,
      this.errorText,
      this.onChange,
      this.prefixIcon,
      this.suffixIcon,
      this.radius = 15,
      this.maxLine = 1,
      this.textCapitalization = TextCapitalization.none});

  final EdgeInsets scrollPadding;
  final TextEditingController controller;
  final EdgeInsetsGeometry padding;
  final double width;
  final TextInputType textInputType;
  final String? hintText;
  final TextStyle? hintStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final int? maxLength;
  final String? errorText;
  final bool passwordField;
  final Function(String)? onChange;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double radius;
  final int maxLine;
  final TextCapitalization textCapitalization;

  @override
  Widget build(BuildContext context) => Container(
      padding: padding,
      height: errorText == null || errorText!.isEmpty ? null : 105,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextField(
        key: !passwordField ? Key('username') : Key('password'),
        style: TextStyle(fontSize: 16),
        controller: controller,
        obscureText: passwordField,
        obscuringCharacter: '*',
        maxLength: maxLength,
        maxLines: maxLine,
        keyboardType: textInputType,
        onChanged: onChange,
        textCapitalization: textCapitalization,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: kPrimaryColor), borderRadius: BorderRadius.circular(radius)),
          filled: true,
          hintText: hintText,
          hintStyle: hintStyle,
          labelText: labelText,
          labelStyle: labelStyle,
          errorText: errorText != null && errorText!.isEmpty ? null : errorText,
          errorMaxLines: 3,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(style: BorderStyle.none, color: kPrimaryColor),
          ),
        ),
      ),
    );
    
}
