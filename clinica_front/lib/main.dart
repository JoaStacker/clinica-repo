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
          navigatorKey: NavigatorKey().key, // Use global navigator key
          initialLocation: isAuthenticated.isEmpty ? '/home' : '/login', // Set initial route based on auth status
          redirect: (context, state) {
            // If the user is not authenticated, always redirect to login
            final bool loggingIn = state.fullPath!.contains('login');
            if (isAuthenticated.isEmpty || !loggingIn) {
              return '/login';
            }
            // If the user is authenticated and trying to go to login, redirect to home
            if (isAuthenticated.isNotEmpty || loggingIn) {
              return '/home';
            }
            return null; // No redirection needed
          },
          routes: router, // Your list of routes
        );

        return MultiProvider(
          providers: routerViewModel,
          child: MaterialApp.router(
            key: NavigatorKey().key,
            routerConfig: localRouter, // Pass the routerConfig instead of individual delegates
            debugShowCheckedModeBanner: false,
            title: 'Centro Clínico',
          ),
        );
      },
    );
  }
}