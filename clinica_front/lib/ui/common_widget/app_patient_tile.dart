import 'package:clinica_front/core/colors.dart';
import 'package:flutter/material.dart';


class AppPatientTile extends StatelessWidget {
  const AppPatientTile({super.key, required this.body, required this.onTap});
  final Widget body;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Card(
        shadowColor: kWhiteAlt70,
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: Padding(
            padding: EdgeInsets.all(8),
            child: body)));
  }
}
