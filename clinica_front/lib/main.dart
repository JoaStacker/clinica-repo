import 'package:clinica_front/locator.dart';
import 'package:clinica_front/router/router.dart';
import 'package:clinica_front/router/router_view_model.dart';
import 'package:clinica_front/services/autentication.dart';
import 'package:clinica_front/services/navegation_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(const CentroClinico());
}

class CentroClinico extends StatelessWidget {
  const CentroClinico({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: locator<AuthenticationService>().isAuthenticated(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading authentication status'));
        }
        return MultiProvider(
          providers: routerViewModel,
          child: MaterialApp(
            navigatorKey: NavigatorKey().key,
            debugShowCheckedModeBanner: false,
            title: 'Centro Clínico',
            initialRoute: snapshot.data!.isEmpty ? '/login' : '/home',
            routes: routes,
          ),
        );
      },
    );
  }
}