import 'package:clinica_front/locator.dart';
import 'package:clinica_front/router/router.dart';
import 'package:clinica_front/router/router_view_model.dart';
import 'package:clinica_front/services/autentication.dart';
import 'package:clinica_front/services/navegation_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  // Inicializamos el AuthenticationService
  await locator<AuthenticationService>().initializeUser();

  runApp(const CentroClinico());
}

class CentroClinico extends StatelessWidget {
  const CentroClinico({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = locator<AuthenticationService>();

    final localRouter = GoRouter(
      navigatorKey: NavigatorKey().key,
      initialLocation: authService.user.token.isEmpty ? '/login' : '/home',
      redirect: (context, state) {
        final loggingIn = state.fullPath == '/login';
        final isAuthenticated = authService.user.token.isNotEmpty;

        if (!isAuthenticated && !loggingIn) {
          return '/login';
        }
        return null; // No redirige si no hay conflictos
      },
      routes: router, // Tu configuración de rutas
    );

    return MultiProvider(
      providers: routerViewModel, // Tu lista de proveedores
      child: MaterialApp.router(
        routerConfig: localRouter,
        debugShowCheckedModeBanner: false,
        title: 'Centro Clínico',
      ),
    );
  }
}