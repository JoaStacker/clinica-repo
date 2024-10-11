import 'package:clinica_front/services/navegation_router.dart';
import 'package:go_router/go_router.dart';

mixin NavegationServices{

  void navigatorPush(String route, {Object? arguments}) {
    final context = NavigatorKey().key.currentContext!;
    GoRouter.of(context).go(route, extra: arguments); // Updated to use GoRouter
  }

  void back({dynamic result}) {
    final context = NavigatorKey().key.currentContext!;
    GoRouter.of(context).pop(); // Updated to use GoRouter
  }
}