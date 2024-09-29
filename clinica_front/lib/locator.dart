// ignore_for_file: prefer_const_constructors

import 'package:clinica_front/services/autentication.dart';
import 'package:clinica_front/services/dialog_service/dialog_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton<FlutterSecureStorage>(() => FlutterSecureStorage());
  locator.registerLazySingleton<AuthenticationService>(() => AuthenticationService());
}
