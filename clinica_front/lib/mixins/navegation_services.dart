import 'package:flutter/material.dart';

mixin NavegationServices{

  void navigatorPush(context, String router, {Object? arguments = false}){
    Navigator.pushNamed(context, router, arguments: arguments);
  }

}