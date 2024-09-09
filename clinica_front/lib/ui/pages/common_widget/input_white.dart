import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWhite extends StatelessWidget {
  const InputWhite(
      {super.key, 
      required this.labelText,
      required this.initString,
      this.keyboardType = TextInputType.text,
      this.enable = true,
      this.inputFormatters,
      this.hintText = '',
      this.maxLength = 250,
      this.validator,
      this.prefix,
      this.onChanged});

  final String initString;
  final String labelText;
  final String? prefix;
  final String hintText;
  final int maxLength;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  final TextInputType keyboardType;
  final bool enable;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      minLines: 1,
      maxLines: 2,
      enabled: enable,
      initialValue: initString,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        prefix: prefix != null ? Text("$prefix ") : null,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        isDense: true,
        fillColor: Colors.white,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.black54)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onChanged: onChanged != null ? (String text) => onChanged!(text) : (String text) {},
    );
  }
}
