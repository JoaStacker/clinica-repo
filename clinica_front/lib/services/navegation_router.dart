import 'package:flutter/material.dart';

class NavigatorKey {
  final key = GlobalKey<NavigatorState>();

  static final NavigatorKey _singleton = NavigatorKey._internal();

  factory NavigatorKey() {
    return _singleton;
  }

  NavigatorKey._internal();
}