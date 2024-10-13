// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clinica_front/locator.dart';
import 'package:clinica_front/services/autentication.dart';
import 'package:flutter/material.dart';

import '../../core/colors.dart';

class AppBarClinica extends StatelessWidget {
  const AppBarClinica({
    super.key,
    required this.size,
    required this.width,
  });
  final Size size;
  final double width;

  @override
  Widget build(BuildContext context) {
    final authService = locator<AuthenticationService>();

    return AppBar(
      backgroundColor: kWhitePure,
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(size.width * 0.05),
        ),
      ),
      title: Container(
        width: width,
        padding: EdgeInsets.only(left: 20),
        child: Image.asset(
          'resources/images/appbar_clinica.png',
          fit: BoxFit.cover,
        ),
      ),
      actions: [
        IconButton(
          onPressed: authService.logout,          
          icon: Icon(Icons.logout_outlined, size: size.width * 0.02))
      ],
    );
  }
}
