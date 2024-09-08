import 'package:clinica_front/mixins/navegation_services.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends ChangeNotifier with NavegationServices{
  final TextEditingController _userInput = TextEditingController();
  TextEditingController get userInput => _userInput;
  final TextEditingController _passwordInput = TextEditingController();
  TextEditingController get passwordInput => _passwordInput;
  String _failureMessage = '';
  String get failureMessage => _failureMessage;
  bool _passwordField = true;
  bool get passwordField => _passwordField;

  void changePasswordField() {
    _passwordField = !_passwordField;
    notifyListeners();
  }
  
  void setFailureMessage(String message) {
    _failureMessage = message;
    notifyListeners();
  }
}