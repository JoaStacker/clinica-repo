import 'package:clinica_front/services/navegation_router.dart';
import 'package:flutter/material.dart';

mixin NavegationServices{

  void navigatorPush(String router, {Object? arguments = false}){
    Navigator.pushNamed(NavigatorKey().key.currentContext!, router, arguments: arguments);
  }

  void back({dynamic result}) {
    final context = NavigatorKey().key.currentContext!;
    Navigator.of(context).pop();
  }
}