import 'package:clinica_front/services/navegation_router.dart';
import 'package:go_router/go_router.dart';

mixin NavegationServices{

  Future<dynamic>? navigateTo({
    required String path,
    Map<String, String>? queryParams,
    bool replace = false,
    Object? arguments,
  }) {
    final context = NavigatorKey().key.currentContext!;

    if (queryParams != null) {
      path = Uri(path: path, queryParameters: queryParams).toString();
    }
    if (replace) {
      context.go(path, extra: arguments);
      return null;
    }
    return context.push(path, extra: arguments); 
  }

  void navigationReplace({
    required String path,
    Map<String, String>? queryParams,
    Object? arguments,
  }) {
    navigateTo(
      path: path,
      queryParams: queryParams,
      arguments: arguments,
      replace: true,
    );
  }

  void back({dynamic result}) {
    final context = NavigatorKey().key.currentContext!;
    context.pop(result);
  }
  
}