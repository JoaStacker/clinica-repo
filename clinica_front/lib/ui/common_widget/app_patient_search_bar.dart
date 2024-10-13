import 'package:clinica_front/core/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class AppPatientSearchBar extends StatelessWidget {
  const AppPatientSearchBar({super.key, required this.onChanged, required this.controller, required this.hintText});

  final Function onChanged;
  final TextEditingController controller;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        color: Color.fromRGBO(30, 30, 30, 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: TextField(
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-ZáéíóúÁÉÍÓÚñÑ ]')),
        ], // Only numbers can be entered
        scrollPadding: const EdgeInsets.only(bottom: 50),
        controller: controller,
        onChanged: (value) => onChanged(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 15, top: 5),
          suffixIcon: Icon(
            Icons.search,
            color: Color.fromRGBO(30, 30, 30, 0.3),
          ),
          hintText: hintText,
          hintStyle: textGrayStyle,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
