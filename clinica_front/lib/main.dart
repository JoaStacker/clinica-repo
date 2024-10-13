import 'package:clinica_front/locator.dart';
import 'package:clinica_front/router/router.dart';
import 'package:clinica_front/router/router_view_model.dart';
import 'package:clinica_front/services/autentication.dart';
import 'package:clinica_front/services/navegation_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
        } else if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error loading authentication status'));
        }

        final isAuthenticated = snapshot.data!;
        final localRouter = GoRouter(
          navigatorKey: NavigatorKey().key, 
          initialLocation: isAuthenticated.isEmpty ? '/home' : '/login',
          redirect: (context, state) {
            final loggingIn = state.fullPath == '/login';
            if (isAuthenticated.isEmpty && !loggingIn) {
              return '/login';
            }
            if (isAuthenticated.isNotEmpty && loggingIn) {
              return '/home';
            }
            return null;
          },
          routes: router,
        );

        return MultiProvider(
          providers: routerViewModel,
          child: MaterialApp.router(
            routerConfig: localRouter,
            debugShowCheckedModeBanner: false,
            title: 'Centro Clínico',
          ),
        );
      },
    );
  }
}
